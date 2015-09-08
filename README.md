# CNBlogs

======================================================================
功能需求

1 博客－服务端

	1.1 列表：http://wcf.open.cnblogs.com/blog/sitehome/paged/2/10
	
	1.2 内容：http://wcf.open.cnblogs.com/blog/post/body/2251556
	
	1.3 评论：http://wcf.open.cnblogs.com/blog/post/2291554/comments/1/10

2 新闻－服务端

	2.1 列表：http://wcf.open.cnblogs.com/news/recent/paged/1/10
	
	2.2 内容：http://wcf.open.cnblogs.com/news/item/121853
	
	2.3 评论：http://wcf.open.cnblogs.com/news/item/123343/comments/1/10

3 搜索－服务端

	3.1 博主：http://wcf.open.cnblogs.com/blog/bloggers/search?t=%E8%80%90
	
		3.1.1 博客：http://wcf.open.cnblogs.com/blog/u/dudu/posts/1/10

4 排行－服务端

	4.1 博主推荐：http://wcf.open.cnblogs.com/blog/bloggers/recommend/1/10
	
	4.2 48H阅读：http://wcf.open.cnblogs.com/blog/48HoursTopViewPosts/20
	
	4.3 10D推荐：http://wcf.open.cnblogs.com/blog/TenDaysTopDiggPosts/20
	
	4.4 新闻推荐：http://wcf.open.cnblogs.com/news/recommend/paged/1/10

5 收藏－本地数据库

	5.1 博客
	
	5.2 博主
	
	5.3 新闻

6 分享－友盟分享

	6.1 博客
	
	6.2 博主
	
	6.3 新闻
	
	6.4 应用

7 数据统计－友盟平台

8 我的

	8.1 广告
	
	8.2 反馈（评价）
	
	8.3 版权
	
======================================================================
数据结构

1 作者－authorModel

	名字：name
	
	主页：uri
	
	头像：avatar

2 博客－blogModel

	ID：identifier
	
	标题：title
	
	描述：summary
	
	发布时间：pubished
	
	更新时间：updated
	
	作者：author
	
	正文链接：link
	
	博客名称：blogapp
	
	赞数量：diggs
	
	浏览数量：views
	
	评论数量：comments

3 博客内容－blogContentModel

    内容：content

4 评论－commentModel

	ID：identifier
	
	标题：title
	
	发布时间：published
	
	更新时间：updated
	
    作者：author
	
	内容：content

5 新闻－newsModel

	ID：identifier
	
	标题：title
	
	描述：summary
	
	发布时间：published
	
	更新时间：updated
	
	新闻链接：link
	
	赞数量：diggs
	
	浏览数量：views
	
	评论数量：comments
	
	主题：topic
	
	主题图标链接：topicIcon
	
	来源：sourceName

6 新闻内容－newsContentModel

	内容：content
	
	插图：imageUrlArray
	
	上一条：prevNews
	
	下一条：nextNews
	
	评论数：commentCount

7 博主－bloggerModel
    
    ID：identifier
    
    标题：title

    更新时间：updated

    主页：link

    博客名称：blogapp

    头像：avatar

    随笔数量：postcount



