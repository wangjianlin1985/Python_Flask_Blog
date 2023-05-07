/*
Navicat MySQL Data Transfer

Source Server         : mysql5.6
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : blog_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2020-06-24 17:13:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `access_log`
-- ----------------------------
DROP TABLE IF EXISTS `access_log`;
CREATE TABLE `access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `remark` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of access_log
-- ----------------------------

-- ----------------------------
-- Table structure for `alembic_version`
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('97e4869aa549');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `content` text,
  `content_html` text,
  `summary` varchar(300) DEFAULT NULL,
  `thumbnail` varchar(200) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `vc` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_article_name` (`name`),
  KEY `author_id` (`author_id`),
  KEY `category_id` (`category_id`),
  KEY `ix_article_timestamp` (`timestamp`),
  KEY `ix_article_title` (`title`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`),
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '国内网络线上推广渠道全面分析', '1', '一提到网上推广，很多人立即联想起微信推广、百度推广及微博推广等，很多国内专业推广公司都会以一站式提供国内网上推广服务。正如本地推广一样，国内网上推广以百度/搜狗/360搜索引擎为入门，配合以沟通、付款及商城集于一身的主打，再加上不少短期的KOL网红作爆炸性品牌推广活动。\r\n\r\n其实，以中国大陆超过14亿人口的市场，推广的渠道比起以上的还要多很多。欲进入国内市场分一杯羹的公司该如何挑选最适合的推广策略呢？到底该如何分配有限推广预算以达到打开中国内地市场销售大门的效果呢？\r\n\r\n一、百度\r\n国内网络线上推广渠道全面分析\r\n\r\n百度于2000年1月于北京中关村创立，是目前国内最大的搜索引擎/人气网站之一，同时也是全球最大的中文搜索引擎及最大的中文网站。\r\n\r\n百度这一词是来自于前南宋词人辛弃疾的一句词：众力寻他千百度\r\n\r\n百度的开始是因为在1999年底身在美国矽谷的李彦宏抱着技术改变世界的梦想, 看到了中国互联网及中文搜索引擎服务的巨大发展潜力，于是他毅然辞掉矽谷的高薪工作，携搜索引擎专利技术于北京中关村创立了百度搜索引擎，所以就有了我们经常说的一句话“百度一下，你就知道”\r\n\r\n二、360搜索\r\n国内网络线上推广渠道全面分析\r\n\r\n360搜索（英语：360 Search，原好搜、360综合搜索），是北京奇虎科技有限公司开发的一款搜索引擎，主打“安全、精准、可信赖”。\r\n\r\n360搜索于2012年8月16日上线， 9月启用独立域名so.com。“奇虎”称，其中“S”代表Safe（安全），“O”代表Open（开放）。2015年“360搜索”更名为“好搜”，次年重新改为“360搜索”，并推出全新口号：“360搜索，So靠谱”。\r\n\r\n借助奇虎360旗下软件的高装机率优势，360搜索上线一周之内就成为了中国大陆市场占有率第二的搜索引擎。截至2015年底，360搜索占中国搜索引擎市场份额的35%，居第二位，仅次于百度。\r\n\r\n三、搜狗搜索\r\n国内网络线上推广渠道全面分析\r\n\r\n搜狗于2004年8月3日推出，是搜狐公司旗下的子公司，目的是增强搜狐网的搜索技能，主要经营搜狐公司的搜索业务。在搜索业务的同时，也推出搜狗输入法、搜狗高速浏览器等服务。\r\n\r\n于2010年8月9日搜狐与阿里巴巴宣布将分拆搜狗成立独立公司，引入战略投资，注资后的搜狗有望成为仅次于百度的中文搜索工具。\r\n\r\n2013年9月16日，腾讯向搜狗注资4.48亿美元，并将旗下的腾讯搜搜业务和其他相关资产并入搜狗，交易完成后腾讯随即获得搜狗完全摊薄后36.5%的股份，而且腾讯持股比例会在近期内增加至40%左右。\r\n\r\n搜狗2014年第四季度营业收入为1.19亿美元，同比增长70%，净利润为1800万美元。2014全年，搜狗营业收入达3.86亿美元，同比增长79%，净利润达3300万美元。目前腾讯的soso已经变成了搜狗，整合了可搜索微信文章，成为各网络营销公司一大助力，目前位居国内搜索引擎第三位。\r\n\r\n四、微博\r\n国内网络线上推广渠道全面分析\r\n\r\n微博是指一种基于用户关系信息分享、传播以及获取的通过关注机制分享简短实时信息的广播式的社交媒体、网络平台，允许用户通过Web、Wap、Mail、App、IM、SMS以及用户可以通过PC、手机等多种移动终端接入，以文字、图片、视频等多媒体形式，实现信息的即时分享、传播互动。\r\n\r\n目前国内有“新浪微博”“腾讯微博”“网易微博”及“搜狐微博”，新浪微博占市场份额80％以上。\r\n\r\n五、微信\r\n国内网络线上推广渠道全面分析\r\n\r\n微信的功能比起市面上的其他即时通讯软件强大，使用者除了可以透过用户端与好友分享文字、图片以及贴图外，并支援分组聊天和语音、视讯对讲功能、广播（一对多）讯息、相片/视讯共用、位置共用、讯息交流联络等服务并有共用串流媒体内容的Feed和基于位置的社交外挂程式「摇一摇」、「漂流瓶」,「朋友探测器」和「附近的人」快速新增好友。后来亦加入了微信支付、理财通，游戏等强大功能。\r\n\r\n用户使用微信大部分功能都是免费的。根据市场研究公司OnDevice调查显示，微信在中国大陆的市场渗透率达93%。截至2018年3月，微信于全球拥有超过约10亿活跃用户。\r\n\r\n同时更新了“微信公众号”在如此庞大的用户群体下，公众号无疑成为一个推广的香饽饽，所以各种大小企业主、个人实体经营者以及一些创业人群甚至官方都以微信公众号为推广载体。\r\n\r\n六、小红书\r\n国内网络线上推广渠道全面分析\r\n\r\n小红书成立于2013年6月，是中国大陆的网上购物及社交平台，截至2019年1月该网站宣称拥有2亿用户，人均活跃用户人数超过150万。在小红书社群，用户和名人可以分享产品评测和旅游目的地介绍，即「种草笔记」。\r\n\r\n小红书的用户有80%以上是女性，主流用户社群是90后及95后。而其中最有兴趣话题是彩妆、护肤、母婴、美食及旅游。\r\n\r\n小红书也为网路和电视的多个节目冠名赞助，为小红书带来用户和内容的增长。有媒体把小红书和Facebook 旗下的Instagram 作比较。由于小红书的笔记能于百度等的搜索引擎中搜索到，加上它的活跃用户数量比例高，更可以配合其销售平台作直接销售，所以是现时较受欢迎的推广渠道之一。\r\n\r\n七、抖音（国内版）\r\n国内网络线上推广渠道全面分析\r\n\r\n抖音是有分开国内版本及国际版本，基本上想推广给中国用户的话只能使用国内版。\r\n\r\n抖音是一款行动电话上影片的社群应用程式，用户可录制15秒钟的短片，能轻易完成对口型，并内建特效，使用者可对影片留言，自2016年9月于今日头条孵化上线，定位为适合中国年轻人的音乐短影片社群，应用为垂直音乐的UGC 短影音，2017年以来获得用户规模快速增长。\r\n\r\n抖音国际版TikTok 的下载和安装量曾在美国市场跃居第一位，并在日本、泰国、印尼、德国、法国和俄罗斯等地，多次登上当地App Store 或Google Play 总榜的首位。\r\n\r\n据抖音产品负责人王晓蔚2017年9月2日表示，「85%的抖音用户在24岁以下，主力达人和用户基本都是95后，甚至00后，截至2018年7月，该应用程式已被150多个国家的超过5亿全球用户下载。」\r\n\r\n八、大众点评\r\n国内网络线上推广渠道全面分析\r\n\r\n大众点评网于2003年4月由张涛成立于上海，其他创始团队成员包括联合创始人李璟、张波、叶树蕻和龙伟。\r\n\r\n大众点评是中国领先的本地生活消费平台，也是全球最早建立的独立第三方消费点评网站，致力于为网友提供餐饮、购物、休闲娱乐及生活服务等领域的商户信息、消费优惠以及发布消费评价的互动平台。\r\n\r\n九、今日头条（头条号）\r\n国内网络线上推广渠道全面分析\r\n\r\n今日头条，曾命名为“今日头条媒体平台”，是今日头条旗下媒体/自媒体平台，致力于帮助企业、机构、媒体和自媒体在移动端获得更多曝光和关注，在移动互联网时代持续扩大影响力，同时实现品牌传播和内容变现。\r\n\r\n另一方面也为今日头条这个用户量众多的平台输出更优质的内容，创造更好的用户体验。\r\n\r\n打造一个良好的内容生态平台，是头条号发展的重要的方向。基于移动端今日头条海量用户基数，通过强大的智能推荐算法，优质内容将获得更多曝光，而业界领先的消重保护机制，让原创者远离侵权烦恼，专注内容创作，借助头条广告和自营广告，让入驻媒体\\自媒体的价值变现有更多可能。\r\n\r\n2019年5月，今日头条创作者均可申请开通头条小店，通过内容变现增加收入。\r\n\r\n头条小店开通后，店铺页面将出现在作者的今日头条、西瓜视频、抖音、火山个人主页，商品可通过图文、视频、微头条、小视频、直播等多种方式展示，方便用户直接购买。\r\n\r\n其它\r\n上方列举的是各个渠道的主流渠道，但也有特别多的同类型或者其余类型的渠道，这里就不一一列举了，大概梳理一下：\r\n\r\n搜索：百度、360、搜狗、搜搜、必应、夸克、神马、头条搜索\r\n\r\n微博：新浪、腾讯、网易、搜狐、天涯论坛\r\n\r\n媒体：头条号、百家号、搜狐号、网易号、企鹅号、大风号、微信公众号、大鱼号、一点资讯、趣头条、豆瓣组、知乎问答等\r\n\r\n总结\r\n国内的线上媒体非常非常丰富，包括部落格、搜索引擎、虚拟社群、RSS、电子邮件、即时通讯/对话链、网络文学、网络杂志、网络电视、六维平台、掘客、印客、换客、威客/沃客等等。\r\n\r\n每一个推广渠道都有自己的推广规则以及推广方式，同时每一个渠道都有一部分独立的用户群体，要想你的品牌覆盖面足够广足够大，都可以去注册尝试。当然，也可以挑一些自己感兴趣或者有心得的渠道去专研，也会获得非常大的效果。\r\n\r\n除了线上媒体外，亦有其他线下推广渠道，如SMS推广、铁路推广、银行配合推广、户外展示屏推广、电邮推广、广告牌、灯箱、车身广告、公交电视等等。\r\n\r\n闲言碎语\r\n如果可能的话，我也会在平常的学习中，或者看到的一些干货，也会分享在博客，大家届时可以在博客右上角点击搜索关键词即可。\r\n国内网络线上推广渠道全面分析\r\n\r\n继续阅读', '<p>一提到网上推广，很多人立即联想起微信推广、百度推广及微博推广等，很多国内专业推广公司都会以一站式提供国内网上推广服务。正如本地推广一样，国内网上推广以百度/搜狗/360搜索引擎为入门，配合以沟通、付款及商城集于一身的主打，再加上不少短期的KOL网红作爆炸性品牌推广活动。</p>\n<p>其实，以中国大陆超过14亿人口的市场，推广的渠道比起以上的还要多很多。欲进入国内市场分一杯羹的公司该如何挑选最适合的推广策略呢？到底该如何分配有限推广预算以达到打开中国内地市场销售大门的效果呢？</p>\n<p>一、百度\n国内网络线上推广渠道全面分析</p>\n<p>百度于2000年1月于北京中关村创立，是目前国内最大的搜索引擎/人气网站之一，同时也是全球最大的中文搜索引擎及最大的中文网站。</p>\n<p>百度这一词是来自于前南宋词人辛弃疾的一句词：众力寻他千百度</p>\n<p>百度的开始是因为在1999年底身在美国矽谷的李彦宏抱着技术改变世界的梦想, 看到了中国互联网及中文搜索引擎服务的巨大发展潜力，于是他毅然辞掉矽谷的高薪工作，携搜索引擎专利技术于北京中关村创立了百度搜索引擎，所以就有了我们经常说的一句话“百度一下，你就知道”</p>\n<p>二、360搜索\n国内网络线上推广渠道全面分析</p>\n<p>360搜索（英语：360 Search，原好搜、360综合搜索），是北京奇虎科技有限公司开发的一款搜索引擎，主打“安全、精准、可信赖”。</p>\n<p>360搜索于2012年8月16日上线， 9月启用独立域名so.com。“奇虎”称，其中“S”代表Safe（安全），“O”代表Open（开放）。2015年“360搜索”更名为“好搜”，次年重新改为“360搜索”，并推出全新口号：“360搜索，So靠谱”。</p>\n<p>借助奇虎360旗下软件的高装机率优势，360搜索上线一周之内就成为了中国大陆市场占有率第二的搜索引擎。截至2015年底，360搜索占中国搜索引擎市场份额的35%，居第二位，仅次于百度。</p>\n<p>三、搜狗搜索\n国内网络线上推广渠道全面分析</p>\n<p>搜狗于2004年8月3日推出，是搜狐公司旗下的子公司，目的是增强搜狐网的搜索技能，主要经营搜狐公司的搜索业务。在搜索业务的同时，也推出搜狗输入法、搜狗高速浏览器等服务。</p>\n<p>于2010年8月9日搜狐与阿里巴巴宣布将分拆搜狗成立独立公司，引入战略投资，注资后的搜狗有望成为仅次于百度的中文搜索工具。</p>\n<p>2013年9月16日，腾讯向搜狗注资4.48亿美元，并将旗下的腾讯搜搜业务和其他相关资产并入搜狗，交易完成后腾讯随即获得搜狗完全摊薄后36.5%的股份，而且腾讯持股比例会在近期内增加至40%左右。</p>\n<p>搜狗2014年第四季度营业收入为1.19亿美元，同比增长70%，净利润为1800万美元。2014全年，搜狗营业收入达3.86亿美元，同比增长79%，净利润达3300万美元。目前腾讯的soso已经变成了搜狗，整合了可搜索微信文章，成为各网络营销公司一大助力，目前位居国内搜索引擎第三位。</p>\n<p>四、微博\n国内网络线上推广渠道全面分析</p>\n<p>微博是指一种基于用户关系信息分享、传播以及获取的通过关注机制分享简短实时信息的广播式的社交媒体、网络平台，允许用户通过Web、Wap、Mail、App、IM、SMS以及用户可以通过PC、手机等多种移动终端接入，以文字、图片、视频等多媒体形式，实现信息的即时分享、传播互动。</p>\n<p>目前国内有“新浪微博”“腾讯微博”“网易微博”及“搜狐微博”，新浪微博占市场份额80％以上。</p>\n<p>五、微信\n国内网络线上推广渠道全面分析</p>\n<p>微信的功能比起市面上的其他即时通讯软件强大，使用者除了可以透过用户端与好友分享文字、图片以及贴图外，并支援分组聊天和语音、视讯对讲功能、广播（一对多）讯息、相片/视讯共用、位置共用、讯息交流联络等服务并有共用串流媒体内容的Feed和基于位置的社交外挂程式「摇一摇」、「漂流瓶」,「朋友探测器」和「附近的人」快速新增好友。后来亦加入了微信支付、理财通，游戏等强大功能。</p>\n<p>用户使用微信大部分功能都是免费的。根据市场研究公司OnDevice调查显示，微信在中国大陆的市场渗透率达93%。截至2018年3月，微信于全球拥有超过约10亿活跃用户。</p>\n<p>同时更新了“微信公众号”在如此庞大的用户群体下，公众号无疑成为一个推广的香饽饽，所以各种大小企业主、个人实体经营者以及一些创业人群甚至官方都以微信公众号为推广载体。</p>\n<p>六、小红书\n国内网络线上推广渠道全面分析</p>\n<p>小红书成立于2013年6月，是中国大陆的网上购物及社交平台，截至2019年1月该网站宣称拥有2亿用户，人均活跃用户人数超过150万。在小红书社群，用户和名人可以分享产品评测和旅游目的地介绍，即「种草笔记」。</p>\n<p>小红书的用户有80%以上是女性，主流用户社群是90后及95后。而其中最有兴趣话题是彩妆、护肤、母婴、美食及旅游。</p>\n<p>小红书也为网路和电视的多个节目冠名赞助，为小红书带来用户和内容的增长。有媒体把小红书和Facebook 旗下的Instagram 作比较。由于小红书的笔记能于百度等的搜索引擎中搜索到，加上它的活跃用户数量比例高，更可以配合其销售平台作直接销售，所以是现时较受欢迎的推广渠道之一。</p>\n<p>七、抖音（国内版）\n国内网络线上推广渠道全面分析</p>\n<p>抖音是有分开国内版本及国际版本，基本上想推广给中国用户的话只能使用国内版。</p>\n<p>抖音是一款行动电话上影片的社群应用程式，用户可录制15秒钟的短片，能轻易完成对口型，并内建特效，使用者可对影片留言，自2016年9月于今日头条孵化上线，定位为适合中国年轻人的音乐短影片社群，应用为垂直音乐的UGC 短影音，2017年以来获得用户规模快速增长。</p>\n<p>抖音国际版TikTok 的下载和安装量曾在美国市场跃居第一位，并在日本、泰国、印尼、德国、法国和俄罗斯等地，多次登上当地App Store 或Google Play 总榜的首位。</p>\n<p>据抖音产品负责人王晓蔚2017年9月2日表示，「85%的抖音用户在24岁以下，主力达人和用户基本都是95后，甚至00后，截至2018年7月，该应用程式已被150多个国家的超过5亿全球用户下载。」</p>\n<p>八、大众点评\n国内网络线上推广渠道全面分析</p>\n<p>大众点评网于2003年4月由张涛成立于上海，其他创始团队成员包括联合创始人李璟、张波、叶树蕻和龙伟。</p>\n<p>大众点评是中国领先的本地生活消费平台，也是全球最早建立的独立第三方消费点评网站，致力于为网友提供餐饮、购物、休闲娱乐及生活服务等领域的商户信息、消费优惠以及发布消费评价的互动平台。</p>\n<p>九、今日头条（头条号）\n国内网络线上推广渠道全面分析</p>\n<p>今日头条，曾命名为“今日头条媒体平台”，是今日头条旗下媒体/自媒体平台，致力于帮助企业、机构、媒体和自媒体在移动端获得更多曝光和关注，在移动互联网时代持续扩大影响力，同时实现品牌传播和内容变现。</p>\n<p>另一方面也为今日头条这个用户量众多的平台输出更优质的内容，创造更好的用户体验。</p>\n<p>打造一个良好的内容生态平台，是头条号发展的重要的方向。基于移动端今日头条海量用户基数，通过强大的智能推荐算法，优质内容将获得更多曝光，而业界领先的消重保护机制，让原创者远离侵权烦恼，专注内容创作，借助头条广告和自营广告，让入驻媒体\\自媒体的价值变现有更多可能。</p>\n<p>2019年5月，今日头条创作者均可申请开通头条小店，通过内容变现增加收入。</p>\n<p>头条小店开通后，店铺页面将出现在作者的今日头条、西瓜视频、抖音、火山个人主页，商品可通过图文、视频、微头条、小视频、直播等多种方式展示，方便用户直接购买。</p>\n<p>其它\n上方列举的是各个渠道的主流渠道，但也有特别多的同类型或者其余类型的渠道，这里就不一一列举了，大概梳理一下：</p>\n<p>搜索：百度、360、搜狗、搜搜、必应、夸克、神马、头条搜索</p>\n<p>微博：新浪、腾讯、网易、搜狐、天涯论坛</p>\n<p>媒体：头条号、百家号、搜狐号、网易号、企鹅号、大风号、微信公众号、大鱼号、一点资讯、趣头条、豆瓣组、知乎问答等</p>\n<p>总结\n国内的线上媒体非常非常丰富，包括部落格、搜索引擎、虚拟社群、RSS、电子邮件、即时通讯/对话链、网络文学、网络杂志、网络电视、六维平台、掘客、印客、换客、威客/沃客等等。</p>\n<p>每一个推广渠道都有自己的推广规则以及推广方式，同时每一个渠道都有一部分独立的用户群体，要想你的品牌覆盖面足够广足够大，都可以去注册尝试。当然，也可以挑一些自己感兴趣或者有心得的渠道去专研，也会获得非常大的效果。</p>\n<p>除了线上媒体外，亦有其他线下推广渠道，如SMS推广、铁路推广、银行配合推广、户外展示屏推广、电邮推广、广告牌、灯箱、车身广告、公交电视等等。</p>\n<p>闲言碎语\n如果可能的话，我也会在平常的学习中，或者看到的一些干货，也会分享在博客，大家届时可以在博客右上角点击搜索关键词即可。\n国内网络线上推广渠道全面分析</p>\n<p>继续阅读</p>', '一提到网上推广，很多人立即联想起微信推广、百度推广及微博推广等，很多国内专业推广公司都会以一站式提供国内网上推广服务。', 'http://127.0.0.1:5000/admin/uploads/20200624153726.png', '1', '8', '2020-06-24 15:16:29', '1', '1');
INSERT INTO `article` VALUES ('2', 'WordPress文件读写权限建议', '2', 'WordPress的文件读写权限和所有权在WordPress网站的整体安全性中发挥着不可或缺的作用，所以我们需要尽可能确保进行合理的设置。在这篇文章中，我们将介绍有关WordPress文件读写权限的所有信息。\r\n\r\nWordPress的简单易用和灵活拓展性，使它成为了是迄今为止最受欢迎的CMS系统。但是，如果你打算使用它，你应该对WordPress安全进行关注。虽然有许多不同的因素需要考虑，但是设置正确的文件读写权限应该是首要任务之一。\r\n\r\n什么是WordPress文件权限？\r\nWordPress文件权限确定谁可以访问WordPress网站上的文件。文件权限本质上是一种组织和管理文件和文件夹的方法。如果未正确设置，可能会使您的网站和网站访问者面临重大风险。\r\n\r\n如果没有正确的文件权限，黑客可以访问你的管理员帐户以及你的整个服务器（你的网站所在的位置）。这可能允许他们读取、写入和执行敏感文件，包括添加在你网站后端运行恶意软件的恶意代码。\r\n\r\n另外，如果你的WordPress网站被多个用户（例如博客文章或新闻资讯的贡献者）使用，正确的文件权限可以防止内部错误的威胁，同时还为他们提供一层保护来应对攻击者。\r\n\r\n虽然文件权限不是WordPress安全实践的唯一关键元素，但它们可确保正确执行文件，使其成为网站功能的关键方面。\r\n\r\n设置WordPress文件权限：FTP 和 宝塔面板\r\n在主动设置文件权限之前，您必须首先知道用于管理网站文件的客户端。通常有两种主要解决方案：FTP和宝塔面板。\r\n\r\n使用FTP设置权限\r\n使用FTP客户端，您需要使用菜单中的chmod或set权限设置文件或文件夹的权限。只需打开文件和文件夹即可。从那里将明确指出权限列表。\r\n\r\n在每个文件上，显示一系列字母和连字符。在字符中，您可以看到以下任何（单数或组合）：\r\n\r\n字母“r”表示用户可以读取文件\r\n字母“w”表示用户具有写入权限\r\n字母“x”表示用户可以执行权限\r\n连字符“ - ”表示没有权限\r\n它们将以某种方式呈现，以显示各个组和用户的设置。在FTP软件中，我们只需要在需要设置权限的文件或文件夹上，右键-属性，就可以进入到权限设置界面。', '<p>WordPress的文件读写权限和所有权在WordPress网站的整体安全性中发挥着不可或缺的作用，所以我们需要尽可能确保进行合理的设置。在这篇文章中，我们将介绍有关WordPress文件读写权限的所有信息。</p>\n<p>WordPress的简单易用和灵活拓展性，使它成为了是迄今为止最受欢迎的CMS系统。但是，如果你打算使用它，你应该对WordPress安全进行关注。虽然有许多不同的因素需要考虑，但是设置正确的文件读写权限应该是首要任务之一。</p>\n<p>什么是WordPress文件权限？\nWordPress文件权限确定谁可以访问WordPress网站上的文件。文件权限本质上是一种组织和管理文件和文件夹的方法。如果未正确设置，可能会使您的网站和网站访问者面临重大风险。</p>\n<p>如果没有正确的文件权限，黑客可以访问你的管理员帐户以及你的整个服务器（你的网站所在的位置）。这可能允许他们读取、写入和执行敏感文件，包括添加在你网站后端运行恶意软件的恶意代码。</p>\n<p>另外，如果你的WordPress网站被多个用户（例如博客文章或新闻资讯的贡献者）使用，正确的文件权限可以防止内部错误的威胁，同时还为他们提供一层保护来应对攻击者。</p>\n<p>虽然文件权限不是WordPress安全实践的唯一关键元素，但它们可确保正确执行文件，使其成为网站功能的关键方面。</p>\n<p>设置WordPress文件权限：FTP 和 宝塔面板\n在主动设置文件权限之前，您必须首先知道用于管理网站文件的客户端。通常有两种主要解决方案：FTP和宝塔面板。</p>\n<p>使用FTP设置权限\n使用FTP客户端，您需要使用菜单中的chmod或set权限设置文件或文件夹的权限。只需打开文件和文件夹即可。从那里将明确指出权限列表。</p>\n<p>在每个文件上，显示一系列字母和连字符。在字符中，您可以看到以下任何（单数或组合）：</p>\n<p>字母“r”表示用户可以读取文件\n字母“w”表示用户具有写入权限\n字母“x”表示用户可以执行权限\n连字符“ - ”表示没有权限\n它们将以某种方式呈现，以显示各个组和用户的设置。在FTP软件中，我们只需要在需要设置权限的文件或文件夹上，右键-属性，就可以进入到权限设置界面。</p>', 'WordPress的文件读写权限和所有权在WordPress网站的整体安全性中发挥着不可或缺的作用，所以我们需要尽可能确保进行合理的设置。在这篇文章中，我们将介绍有关WordPress文件读写权限的所有信息。', 'http://127.0.0.1:5000/admin/uploads/20200624163126.png', '1', '0', '2020-06-24 16:29:37', '1', '1');
INSERT INTO `article` VALUES ('3', '鲜橙红豆糖水', '3', '在油管子网站，忘了是哪位直播主，分享了在糖水中放鲜橙子的视频，视频可以看出，加了橙子让甜甜的糖水多了一分水果的香味，笔者在这里谢谢TA。本来呢，广东人在煮红豆绿豆糖水时喜欢放陈皮，这次就破一次例，放一个新鲜的橙子。\r\n\r\n![](http://127.0.0.1:5000/admin/uploads/20200624163631.jpg)\r\n\r\n主料：中国红豆1/2杯、美国红豆1/2杯、橙子1个。\r\n\r\n调料：红糖粉适量。\r\n\r\n一、把红豆泡约2小时，洗净倒入压力锅；\r\n\r\n二、用粥档，调时间为30分钟；\r\n\r\n三、把豆和汤一起倒入另一锅（感觉操作方便些，不换锅也可以的），再放一个橙子，大火烧开后改慢火，煮约20分钟，把橙味煮出来；\r\n\r\n四、用细密网筛把浮沫滗出来；\r\n\r\n五、加适量的红糖粉，煮溶，试味，甜度合适就OK了。Enjoy !', '<p>在油管子网站，忘了是哪位直播主，分享了在糖水中放鲜橙子的视频，视频可以看出，加了橙子让甜甜的糖水多了一分水果的香味，笔者在这里谢谢TA。本来呢，广东人在煮红豆绿豆糖水时喜欢放陈皮，这次就破一次例，放一个新鲜的橙子。</p>\n<p><img alt=\"\" src=\"http://127.0.0.1:5000/admin/uploads/20200624163631.jpg\" /></p>\n<p>主料：中国红豆1/2杯、美国红豆1/2杯、橙子1个。</p>\n<p>调料：红糖粉适量。</p>\n<p>一、把红豆泡约2小时，洗净倒入压力锅；</p>\n<p>二、用粥档，调时间为30分钟；</p>\n<p>三、把豆和汤一起倒入另一锅（感觉操作方便些，不换锅也可以的），再放一个橙子，大火烧开后改慢火，煮约20分钟，把橙味煮出来；</p>\n<p>四、用细密网筛把浮沫滗出来；</p>\n<p>五、加适量的红糖粉，煮溶，试味，甜度合适就OK了。Enjoy !</p>', '在油管子网站，忘了是哪位直播主，分享了在糖水中放鲜橙子的视频，视频可以看出，加了橙子让甜甜的糖水多了一分水果的香味，笔者在这里谢谢TA。本来呢，广东人在煮红豆绿豆糖水时喜欢放陈皮，这次就破一次例，放一个新鲜的橙子。', 'http://127.0.0.1:5000/admin/uploads/20200624163730.jpg', '1', '1', '2020-06-24 16:32:22', '1', '2');

-- ----------------------------
-- Table structure for `article_tag`
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `article_tag_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `article_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_tag
-- ----------------------------
INSERT INTO `article_tag` VALUES ('1', '1');
INSERT INTO `article_tag` VALUES ('2', '3');
INSERT INTO `article_tag` VALUES ('3', '4');

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `desp` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_category_name` (`name`),
  UNIQUE KEY `ix_category_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '技术分享', 'jsfx', '分享一些技术信息');
INSERT INTO `category` VALUES ('2', '美食旅游', 'msly', '分享美食旅游信息');

-- ----------------------------
-- Table structure for `invitation_code`
-- ----------------------------
DROP TABLE IF EXISTS `invitation_code`;
CREATE TABLE `invitation_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `user` varchar(64) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of invitation_code
-- ----------------------------
INSERT INTO `invitation_code` VALUES ('1', 'b6LYiWpfj2ZqeQU', 'dashen', '0');
INSERT INTO `invitation_code` VALUES ('2', 'kC4rBtkZrPJlCfH', null, '1');
INSERT INTO `invitation_code` VALUES ('3', 'AjodGEbLxuLWtzv', null, '1');
INSERT INTO `invitation_code` VALUES ('4', 'zgTyl8jGe8axoPJ', null, '1');
INSERT INTO `invitation_code` VALUES ('5', 'b0VfgCGNXU50qAk', null, '1');

-- ----------------------------
-- Table structure for `online_tool`
-- ----------------------------
DROP TABLE IF EXISTS `online_tool`;
CREATE TABLE `online_tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `desp` varchar(120) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `sn` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of online_tool
-- ----------------------------
INSERT INTO `online_tool` VALUES ('1', '百度翻译', '翻译不懂的中文到英文', 'http://127.0.0.1:5000/admin/uploads/20200624013328.jpg', 'https://fanyi.baidu.com/', '0', '1', '2020-06-24 01:33:43');
INSERT INTO `online_tool` VALUES ('2', 'MD5加密解密', '加密和解密MD5工具', 'http://127.0.0.1:5000/admin/uploads/20200624165543.jpg', 'https://www.cmd5.com/', '1', '1', '2020-06-24 01:33:43');

-- ----------------------------
-- Table structure for `picture`
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `remark` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of picture
-- ----------------------------
INSERT INTO `picture` VALUES ('1', 'QQ截图20200624013306.jpg', '2020-06-24 01:33:29', '/admin/uploads/20200624013328.jpg', null);
INSERT INTO `picture` VALUES ('2', '1.png', '2020-06-24 15:37:26', '/admin/uploads/20200624153726.png', null);
INSERT INTO `picture` VALUES ('3', '2.png', '2020-06-24 16:31:26', '/admin/uploads/20200624163126.png', null);
INSERT INTO `picture` VALUES ('4', '4.jpg', '2020-06-24 16:36:32', '/admin/uploads/20200624163631.jpg', null);
INSERT INTO `picture` VALUES ('5', '5.jpg', '2020-06-24 16:37:30', '/admin/uploads/20200624163730.jpg', null);
INSERT INTO `picture` VALUES ('6', '8.jpg', '2020-06-24 16:55:44', '/admin/uploads/20200624165543.jpg', null);

-- ----------------------------
-- Table structure for `recommend`
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `sn` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recommend
-- ----------------------------

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_tag_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('2', 'word');
INSERT INTO `tag` VALUES ('3', 'wordpress');
INSERT INTO `tag` VALUES ('4', '红豆糖水');
INSERT INTO `tag` VALUES ('1', '线上推广');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `member_since` datetime DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `role` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_email` (`email`),
  UNIQUE KEY `ix_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '254540457@qq.com', 'pbkdf2:sha256:150000$AoE05e8i$1383ecdcce49ca23bef82492aba5b92ce90b36f4ea89e42d922dce8231886e3d', '2020-06-23 17:14:42', '2020-06-24 08:50:16', '1', '1');
INSERT INTO `user` VALUES ('2', 'dashen', '344245001@qq.com', 'pbkdf2:sha256:150000$gB5C9Q6Q$ec8f262dc040605e762ebd186bcf2b4e687b72da834c70ef31837c2a96915d53', '2020-06-24 07:12:20', '2020-06-24 07:12:20', '1', '0');
