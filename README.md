#haoqibao-s
总览
1.APP设计采用传统MVC框架，M存储用户数据，V展示用户界面，C处理数据界面交互。
2.APP为普通标签栏导航栏结合的结构，总共涉及四个模块：首页、教育、广场、我的。
开发说明
1.开发环境与语言：MAC10.11.5，Xcode7.3.1 Objective-C2.0
2.使用pod三方说明：MBProgressHUD（进度显示）、SDWebImage（图片缓存下载）、IQKeyboardManager（键盘管理）、AFNetWorking（网络请求）、MJRefresh（刷新）、FDFullscreenPopGesture（导航栏手势）
详细说明
1.引用pch文件（默认所有文件导入这个头文件）head文件：Pod（三方）、Common（公共类）、Category（类别）、API（API接口）、Attribute（颜色、字体等快捷设置）

2.文件存放：FrameWork（系统库与静态库）；
Main—>Home（首页）、Education（教育）、Square（广场）、Mine（我的）、
Base—>Model（head,tool）、View（封装的工具视图）；Controller（BaseTabberBarController，BaseViewController,BaseUserInfo,BaseNetWorking......）；

3.逻辑关系：
APPDeleGate：启动IQKeyboardManager，设置根视图，设置导航栏统一样式，加载Cookie、支付宝回调。
BaseTabBarController：采用系统自带tabbarItem，设置切换控制器。
BaseViewController:设置背景颜色，设置通用方法如：隐藏标签栏、刷新页面*

4.模块说明
4.1：首页
整体为TableView—>HeardView（新闻滚动、四个小菜单、收益展示），单元格分为三组具体结合需求文档。
4.2：教育
整体为TableView—>导航栏设置透明，包含搜索按钮；单元格统一样式，点击直接打开视屏播放器（AVPlayer）
4.3：广场（活动在哪里？）
整体为TableView—>头视图下拉放大，点击进入WebView；单元格统一样式（存在热门标志），点击打开WebView。
4.4：我的
整体为TableView—>单元格分四组（用户信息、财产、个人业务、额外服务）

5.MVC设计
Model设置相对应的属性，View创建Model对象，并在setModel中对当前视图进行修改，Controller中从网络加载数据并存入Model对象，将Model对象传递给View达成交互。
6.代码风格
项目中将会大量使用封装基类的做法，对于重复使用的视图进行子类化（一般以Base-开头），并采用响应者链关系，在控制器中执行相应方法。




