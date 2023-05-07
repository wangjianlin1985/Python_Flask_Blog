from flask import render_template, redirect, request, current_app, \
    url_for, g, send_from_directory, abort, flash
from flask_login import login_user, logout_user, login_required, current_user
from . import main
from app.models import Article, Tag, Category, article_tag, Recommend, User, \
     InvitationCode, OnlineTool
from .forms import SearchForm, LoginForm,RegistForm, PasswordForm, InviteRegistForm
from app.extensions import db
from ..import db, sitemap
from app.util import get_bing_img_url


@main.before_request
def before_request():
    if '/css/' in request.path or '/js/' in request.path or '/img/' in request.path:
        return
    g.tags = Tag.query.all()
    g.categorys = Category.query.all()
    g.recent_articles = Article.query.filter(Article.state ==1).order_by(Article.timestamp.desc()).limit(10).all()
    g.search_form = SearchForm(prefix='search')


@main.route('/', methods=['GET'])
def index():
    page = request.args.get('page', 1, type=int)
    articles = Article.query.filter_by(state=1). \
        order_by(Article.timestamp.desc()). \
        paginate(page, per_page=current_app.config['H3BLOG_POST_PER_PAGE'], error_out=False)

    recommends = Recommend.query.filter(Recommend.state == 1).order_by(Recommend.sn.desc()).all()
    return render_template('index.html', articles=articles, recommends = recommends)

@main.route('/favicon.ico')
def favicon():
    return main.send_static_file('img/favicon.ico')

@main.route('/hot/',methods=['GET'])
def hot():
    page = request.args.get('page',1,type=int)
    articles = Article.query.filter_by(state=1). \
        order_by(Article.vc.desc()). \
        paginate(page,per_page=current_app.config['H3BLOG_POST_PER_PAGE'],error_out=False)
    recommends = Recommend.query.filter(Recommend.state == 1).order_by(Recommend.sn.desc()).all()
    return render_template('index.html',articles=articles, recommends = recommends)

@main.route('/about/', methods=['GET', 'POST'])
def about():
    article = Article.query.filter(Article.name=='about-me').first()
    if article :
        article.vc = article.vc + 1
        return render_template('article.html', article=article)
    return render_template('about.html')


@main.route('/article/<name>/', methods=['GET', 'POST'])
def article(name):
    article = Article.query.filter_by(name=name).first()
    if article is None:
        abort(404)
    article.vc = article.vc + 1
    db.session.commit()
    import locale
    locale.setlocale(locale.LC_CTYPE, 'chinese')
    return render_template('article.html', article=article)

@main.route('/tags/')
def tags():
    tags = Tag.query.all()
    return render_template('tags.html',tags = tags)


@main.route('/tag/<t>/', methods=['GET'])
def tag(t):
    page = request.args.get('page', 1, type=int)
    tag = Tag.query.filter_by(name=t).first()
    articles = tag.articles.filter(Article.state == 1).\
        order_by(Article.timestamp.desc()). \
        paginate(page, per_page=current_app.config['H3BLOG_POST_PER_PAGE'], error_out=False)
    return render_template('tag.html', articles=articles, tag=tag,orderby='time')

@main.route('/tag/<t>/hot/', methods=['GET'])
def tag_hot(t):
    page = request.args.get('page', 1, type=int)
    tag = Tag.query.filter_by(name=t).first()
    articles = tag.articles.filter(Article.state == 1).\
        order_by(Article.vc.desc()). \
        paginate(page, per_page=current_app.config['H3BLOG_POST_PER_PAGE'], error_out=False)
    return render_template('tag.html', articles=articles, tag=tag,orderby='hot')


@main.route('/category/<c>/', methods=['GET', 'POST'])
def category(c):
    """
    文章分类列表
    """
    page = request.args.get('page', 1, type=int)
    cty = Category.query.filter_by(name=c).first()
    articles = Article.query.filter_by(category=cty,state=1).order_by(Article.timestamp.desc()). \
        paginate(page, per_page=current_app.config['H3BLOG_POST_PER_PAGE'], error_out=False)

    return render_template('category.html', articles=articles, category=cty,orderby='time')

@main.route('/category/<c>/hot/', methods=['GET', 'POST'])
def category_hot(c):
    page = request.args.get('page', 1, type=int)
    cty = Category.query.filter_by(name=c).first()
    articles = Article.query.filter_by(category=cty,state=1).order_by(Article.vc.desc()). \
        paginate(page, per_page=current_app.config['H3BLOG_POST_PER_PAGE'], error_out=False)

    return render_template('category.html', articles=articles, category=cty,orderby='hot')

@main.route('/archive/',methods=['GET'])
def archive():
    """
    根据时间归档
    """
    articles = Article.query.filter_by(state=1).order_by(Article.timestamp.desc()).all()
    time_tag = []
    current_tag = ''
    for a in articles:
        a_t = a.timestamp.strftime('%Y-%m')
        if  a_t != current_tag:
            tag = dict()
            tag['name'] = a_t
            tag['articles'] = []
            time_tag.append(tag)
            current_tag = a_t
        tag = time_tag[-1]
        tag['articles'].append(a)
    return render_template('archives.html',time_tag = time_tag)

@main.route('/search/', methods=['POST'])
def search():
    if not g.search_form.validate_on_submit():
        return redirect(url_for('.index'))

    return redirect(url_for('.search_results', query=g.search_form.search.data.strip()))


@main.route('/search_results/<query>', methods=['GET', 'POST'])
def search_results(query):
    page = request.args.get('page', 1, type=int)
    articles = Article.query.filter(Article.content_html.like('%%%s%%' % query)).order_by(Article.timestamp.desc()). \
        paginate(page, per_page=current_app.config['H3BLOG_POST_PER_PAGE'], error_out=False)
    return render_template('search_result.html', articles=articles, query=query)

@sitemap.register_generator
def sitemap():
    """
    sitemap生成
    """
    articles = Article.query.filter(Article.state == 1).all()
    categories = Category.query.all()
    tags = Tag.query.all()
    import datetime
    now = datetime.datetime.now()
    #首页
    yield 'main.index',{},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',1.0
    #关于我
    yield 'main.about',{},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',0.5
    #分类
    for category in categories:
        yield 'main.category',{'c':category.name},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',0.9
    for categories in categories:
        yield 'main.category_hot',{'c':category.name},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',0.9
    #标签
    yield 'main.tags',{},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',0.9
    for t in tags:
        yield 'main.tag',{'t':t.name},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',0.9
    for t in tags:
        yield 'main.tag_hot',{'t':t.name},now.strftime('%Y-%m-%dT%H:%M:%S'),'always',0.9

    #文章
    for a in articles:
        #posts.post是文章视图的endpoint,后面是其参数
        yield 'main.article',{'name':a.name}

@main.route('/robots.txt')
def robots():
    return send_from_directory(main.static_folder,'robots.txt')

@main.route('/tool/')
def tool():
    tools = OnlineTool.query.order_by(OnlineTool.sn.desc()). \
        filter(OnlineTool.state == True).all()
    return render_template('tool.html',tools = tools)


@main.route('/login', methods=['GET', 'POST'])
def login():
    login_form = LoginForm(prefix='login')
    if login_form.validate_on_submit():
        u = User.query.filter_by(username=login_form.username.data.strip()).first()
        if u is None:
            flash({'error': '帐号未注册！'})
        elif u is not None and u.verify_password(login_form.password.data.strip()) and u.status:
            login_user(user=u, remember=login_form.remember_me.data)
            flash({'success':'欢迎{}登陆成功'.format(u.username)})
            return redirect(request.args.get('next',url_for('main.index')))
        elif not u.status:
            flash({'error': '用户已被管理员注销！'})
        elif not u.verify_password(login_form.password.data.strip()):
            flash({'error': '密码不正确！'})

    return render_template('login.html', form=login_form)

@main.route('/regist', methods=['GET', 'POST'])
def regist():
    '''
    注册
    '''
    is_use_invite_code = current_app.config['H3BLOG_REGISTER_INVITECODE']
    form = RegistForm(prefix='regist')
    if is_use_invite_code:
        form = InviteRegistForm(prefix='regist')
    if form.validate_on_submit(): 
        u = User(username=form.username.data.strip(),
                email=form.email.data.strip(),
                password=form.password.data.strip(),
                status=True, role=False
                )
        db.session.add(u)
        if is_use_invite_code:
            ic = InvitationCode.query.filter(InvitationCode.code == form.code.data.strip()).first()
            if ic :
                ic.user = u.username
                ic.state = False
        
        db.session.commit()
        login_user(user=u)
        flash({'success':'欢迎{}注册成功'.format(u.username)})
        return redirect(request.args.get('next',url_for('main.index')))
    return render_template('regist.html',form=form)

@main.route('/logout')
@login_required
def logout():
    """退出系统"""
    logout_user()
    return redirect(url_for('main.index'))

@main.route('/profile/',methods=['GET'])
def profile():
    '''个人信息'''
    return render_template('profile.html')

@main.route('/password',methods=['GET','POST'])
def password():
    '''修改密码'''
    form = PasswordForm()
    if form.validate_on_submit():
        if current_user.verify_password(form.pwd.data):
            current_user.password = form.password.data
            db.session.commit()
        flash({'success':'修改密码成功'})
        return redirect(url_for('.profile'))
    return render_template('password.html',form=form)


@main.route('/bing_bg')
def bing_bg():
    '''
    获取背景地址
    '''
    return redirect(get_bing_img_url())