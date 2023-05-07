import os
import logging
import click
from logging.handlers import RotatingFileHandler
from flask import Flask, render_template, request
from flask_sqlalchemy import get_debug_queries
from flask_wtf.csrf import CSRFError
from app.util import pretty_date
from app.extensions import db, sitemap, login_manager, migrate,app_helper
from app.settings import config
from app.template_filter import register_template_filter
from app.models import AccessLog

basedir = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))

def create_app(config_name=None):
    if config_name is None:
        config_name = os.getenv('FLASK_CONFIG', 'development')

    """ 使用工厂函数初始化程序实例"""
    app = Flask(__name__)
    app.config['CONFIG_NAME'] = config_name
    app.config.from_object(config[config_name])

    register_logging(app)
    register_extensions(app)
    register_blueprints(app)
    register_commands(app)
    register_errors(app)
    register_shell_context(app)
    register_request_handlers(app)
    register_jiaja2_filters(app)
    register_template_filter(app)

    return app


def register_logging(app):
    class RequestFormatter(logging.Formatter):

        def format(self, record):
            record.url = request.url
            record.remote_addr = request.remote_addr
            return super(RequestFormatter, self).format(record)

    request_formatter = RequestFormatter(
        '[%(asctime)s] %(remote_addr)s requested %(url)s\n'
        '%(levelname)s in %(module)s: %(message)s'
    )

    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    file_handler = RotatingFileHandler(os.path.join(basedir, 'logs/h3blog.log'),
                                       maxBytes=10 * 1024 * 1024, backupCount=10)
    file_handler.setFormatter(formatter)
    file_handler.setLevel(logging.INFO)

    if not app.debug:
        app.logger.addHandler(file_handler)


def register_extensions(app):
    db.init_app(app)
    login_manager.init_app(app)
    sitemap.init_app(app)
    migrate.init_app(app,db=db)
    app_helper.init_app(app)

    


def register_blueprints(app):
    # 注册蓝本 main
    from app.main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    # 注册蓝本 admin
    from app.admin import admin as admin_blueprint
    app.register_blueprint(admin_blueprint, url_prefix='/admin')

def register_shell_context(app):
    @app.shell_context_processor
    def make_shell_context():
        from app.models import User, Article, Category, \
            Tag, article_tag, Recommend, Picture
        return dict(db=db, User=User, Article=Article, \
            Category=Category, Tag=Tag, Recommend = Recommend, \
                AccessLog = AccessLog, Picture = Picture)


def register_errors(app):
    pass

def register_request_handlers(app):
    from flask_login import current_user
    @app.context_processor
    def context_processor():
        '''
        上下文处理器, 返回的字典可以在全部模板中使用
        '''
        return {'current_user': current_user}

    @app.before_request
    def before_app_request():
        user_agent = request.headers.get("User-Agent")
        if user_agent is None:
            return
        remark = None
        if 'Baiduspider' in user_agent :
            remark = '百度'
        if 'Bytespider' in user_agent :
            remark = '头条搜索'
        if 'YisouSpider' in user_agent:
            remark = '神马搜索'
        if 'Sogou' in user_agent:
            remark = '搜狗'
        if 'Sosospider' in user_agent:
            remark = '搜搜'

        if remark :    
            accessLog = AccessLog(ip = request.remote_addr,
                url = request.path,
                remark = remark)
            db.session.add(accessLog)

    @app.after_request
    def query_profiler(response):
        for q in get_debug_queries():
            if q.duration >= app.config['H3BLOG_SLOW_QUERY_THRESHOLD']:
                app.logger.warning(
                    'Slow query: Duration: %fs\n Context: %s\nQuery: %s\n '
                    % (q.duration, q.context, q.statement)
                )
        return response

def register_jiaja2_filters(app):
    env = app.jinja_env
    env.filters['pretty_date'] = pretty_date #注册自定义过滤器


def register_commands(app):
    @app.cli.command()
    @click.option('--drop', is_flag=True, help='Create after drop.')
    def initdb(drop):
        """Initialize the database."""
        if drop:
            click.confirm('This operation will delete the database, do you want to continue?', abort=True)
            db.drop_all()
            click.echo('Drop tables.')
        db.create_all()
        click.echo('Initialized database.')
