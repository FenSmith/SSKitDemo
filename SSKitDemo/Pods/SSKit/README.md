**简介**

```
SSKit是一个以ReactiveCocoa为基础的MVVM模式的简易的iOS开发框架
```

**使用方式**

```
pod 'SSKit', '~> 1.1.1-beta'
```

**基础构成**

- [x] SSCategory
- [x] SSService
- [x] SSHandler
- [x] SSConfigure
- [x] SSMVVM
- [x] SSInherits
- [x] 其他UI控件

**基本用法**

SSKit以<SSHandler/SSAppHandler>为基础配置文件,其中所使用的项目必须指定全局的服务器地址:

```
- (NSString *)ssah_server {
return @"http://120.0.0.1/3000";
}
```

其他非必须配置:

```
- (NSDictionary *)ssah_HTTPHeaderFields {
return @{};
}

- (NSDictionary *)ssah_encryptParams:(NSDictionary *)params {
return params;
}

- (id)ssah_handleServerCallback:(id)callback error:(NSError *)error params:(NSDictionary *)params requestURL:(NSURL *)requestURL {
if (error) {
return error;
}
return callback;
}

- (UIImage *)ssah_navigationBackgroundImage {
return [UIColor blueColor].colorImage;
}

- (NSDictionary *)ssah_navigationTextAttributes {
return @{NSFontAttributeName : [UIFont systemFontOfSize:20],
NSForegroundColorAttributeName : [UIColor blackColor]};
}

- (SSPageTitleType)ssah_navigationTitleType {
return SSPageTitleTypeLeft;
}
```

