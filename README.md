**前言**

之前因为做一个蓝牙设备项目，有很多变量会在设备运行时进行时时改变，往往多达十几种变量，用传统的MVC式直接setValue会十分的麻烦，传值的时候往往代码会‘琳琅满目’，之后就接触了ReactiveCocoa这个框架，其实只用这个框架就能很大程度地解决了我这个项目中的问题，视图绑定变量，变量变了，视图就变了。

再之后因为block回调之类写多了，难免会觉得不协调，就又接触了MVVM这个设计模式。

后来我开始尝试地将两者结合起来，发现还挺好用。之后我抽出了一些基类，命名为SSView，SSViewModel，SSViewController等，其实SSView与SSViewController是同一级关系，因为Cocoa框架的问题，还是带有一些MVC的影子的。再之后我在这个基础上加入了SSTableViewModel，SSTableViewController以及SSScrollController来满足列表型的页面。之后做了个网页，就添加了一个网页相关的SSHTTPViewModel与SSHTTPController。再之后又添加了一些Cell,最后加上了SSTabbarViewModel，SSTabbarController。Tabbar相关的我重新复制粘贴了一套作用于SSViewController上的代码，因为UITabbarController与SSViewController不太一样，理论上是可以用SSViewController替代UITabbarController的，但是现在还没有做。

这样项目就初步成型了，但是网页跳转是根据<u>SSViewModelService</u>生成的变量用RAC来进行绑定跳转的，每次跳转都要在ViewModel中写`[self.service pushViewModel:<#(SSViewModel *)#> animated:<#(BOOL)#>]`之类的语句，时间长了就会觉得很麻烦。后来接触了协议跳转，就有了SSPageRouter。

这下子项目终于差不多有个样子了，以前是直接集成在现有的项目中的，想要单独分离出来重新以这个为基础开一个项目也是可以的，但是是要直接拖文件，很不爽。所以我做成了一个pod。其中我加入了一些常用的Category,以及一些自定义UI组件，还是一些网络请求单例与地理位置请求单例做成一个Service文件夹。

因为自己同时也在接触node.js，打算做个dota2社区App，就试着用这个SSKit作为基础搭建项目，效果还不错。再之后就提取了一些基础配置放到一个专门文件中，SSAppHandler就随之产生了，其中项目中的`ssah_server`是必要的。

写到这其实差不多就已经把我的经历写完了。自己的话其实只开发了一年半多点时间，也没花很多时间在这上面，主要没什么人用，也没什么人说我哪里不对。写了这个之后希望大家能够下载我的代码，使用它，并帮我提出一些意见。在此谢过了。



**项目结构**

[SSKit](https://github.com/bassamyan/SSKit)中主要的结构分为六个部分

1. [SSCategory](https://github.com/bassamyan/SSCategory) ：一些常用的分类
2. [SSConfigure](https://github.com/bassamyan/SSConfigure) ：一些宏定义
3. [SSHandler](https://github.com/bassamyan/SSHandler) ：SSKit项目中的一些基础配置（很重要）
4. [SSMVVM](https://github.com/bassamyan/SSKit) ：SSKit作为一个MVVM框架的基础
5. [SSService](https://github.com/bassamyan/SSService) ：服务单例
6. [SSInherits](https://github.com/bassamyan/SSInherits) ：SSKit中的一些继承的控件
7. SSKit的一些附属组件

SSKit附属组件

1. [SSDialog](https://github.com/bassamyan/SSDialog.git) ：消息弹框

2. [SSAlertView](https://github.com/bassamyan/SSAlertView) ：弹出视图

3. [SSProgressIndicator](https://github.com/bassamyan/SSProgressIndicator) ：横向的进度指示器，用于网页加载

4. [SSStatus](https://github.com/bassamyan/SSStatus) ：状态视图，用于网络加载失败点击重新加载情况之类的情况

5. [SSTabbar](https://github.com/bassamyan/SSTabbar)

6. [SSPullRefresh](https://github.com/bassamyan/SSPullRefresh) ：刷新视图

7. [SSPageControl](https://github.com/bassamyan/SSPageControl) 

   ​

**SSMVVM简介**

SSMVVM是这个框架中的最基本、最核心的类，他决定了页面的组成、页面的跳转等一系列基础。其中包含如下结构

1. SSViewModelService
2. SSViewModelServiceImpl
3. SSView
4. SSViewModel
5. SSViewController
6. SSTableViewModel
7. SSTableViewController
8. SSTabbarViewModel
9. SSTabbarController
10. SSTableViewCell
11. SSCollectionViewCell
12. SSScrollController
13. SSHTTPViewModel
14. SSHTTPController
15. SSNavigatorStacks
16. SSNavigatorController
17. SSBarEntity
18. SSPageRouter

SSViewModelService作为一个@protocol能够起到页面跳转中枢的作用，而SSViewModelServiceImpl是其实现。在SSViewModel具体是作为一个service变量。我在之后在SSPageRouter中做了集成，用协议进行跳转。例如在App启动的时候设置根控制器：

```
[SSPageRouter resetPageWithProtocol:@"sspage://DTBTabbarViewModel"];
```

<u>sspage://</u>是作为协议的一部分必须填写的。假如我要跳转一个页面，则可以用以下代码实现：

```
[SSPageRouter openProtocol:@"sspage://DTBRegistViewModel"];
```

该语句效果等同于push操作，同样还有present操作。由于这是基于SSKit中的SSViewModel创建的视图，假如我想打开系统的相册视图，也可以用以下语句：

```
+ (void)openController:(UIViewController *)controller
```

以一个完整的方法作为例子：

```
+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated;
```

protocol表示谢意，params表示ViewModel中的变量，在初始化后会用runtime进行赋值，ctrParams是Controller中的变量，同样在初始化用会用runtime赋值。

SSViewModel在初始化后会调用两个方法：

```
- (void)viewModelDidLoad; // Step1
- (void)viewModelLoadNotifications; // Step2
```

第一个用于设置一些变量，比如RAC绑定操作，设置导航栏上的按键等。第一个方法与第二个方法其实可以合在一起，但是因为我之前经常将通知也与第一个方法写在一起，代码就比较冗杂，所以就将通知的方法单独拿了出来作为一个方法。创建完ViewModel之后在SSPageRouter中会通过

```
NSString *className = NSStringFromClass([viewModel class]);
id ctr = [[NSClassFromString(ctrName) alloc] initWithViewModel:viewModel];
```

将它转换成一个控制器，然后交由<u>SSNavigatorStacks</u>进行处理用于页面跳转。



**SSHandler简介**

SSHandler是一个用于配置SSKit全局项的单例,首先必须遵守SSHandlerDelegate,以下方法是必填

```
- (NSString *)ssah_server;
```

以下方法是非必须的

```
- (NSDictionary *)ssah_HTTPHeaderFields;
- (NSDictionary *)ssah_encryptParams:(NSDictionary *)params;
- (id)ssah_handleServerCallback:(id)callback error:(NSError *)error params:(NSDictionary *)params requestURL:(NSURL *)requestURL;
- (UIImage *)ssah_navigationBackgroundImage;
- (NSDictionary *)ssah_navigationTextAttributes;
- (UIImage *)ssah_navigationbarShadowImage;
- (UIImage *)ssah_navigationbarImage;
- (UIImage *)ssah_navigationbarHighlightImage;
- (CGFloat)ssah_navigationbarItemsSpareSpace;
- (SSPageTitleType)ssah_navigationTitleType;
- (UIColor *)ssah_webProgressIndicatorColor;
```