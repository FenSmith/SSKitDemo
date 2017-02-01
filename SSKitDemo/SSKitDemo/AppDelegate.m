//
//  AppDelegate.m
//  SSKitDemo
//
//  Created by QuincyYan on 16/12/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <SSAppHandlerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [SSAppHandler sharedHander].delegate = self;
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [SSPageRouter resetPageAttachProtocol:@"sspr://DTBTabbarViewModel"];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (NSString *)ssah_server {
    return @"http://127.0.0.1:3000/";
}

- (NSDictionary *)ssah_HTTPHeaderFields {
    return @{};
}

- (id)ssah_handleServerCallback:(id)callback error:(NSError *)error params:(NSDictionary *)params requestURL:(NSURL *)requestURL {
    if (callback) {
        NSLog(@"\n\n\n请求成功:\n%@\n请求的参数:\n%@\n请求的地址:\n%@\n",callback,params,requestURL.absoluteString);
        NSInteger code = [callback[@"code"] integerValue];
        if (code == 200) {
            id data = callback[@"result"];
            if (![data isKindOfClass:[NSNull class]]) {
                if ([data isKindOfClass:[NSArray class]]) {
                    if ([(NSArray *)data count] == 0) {
                        return [NSError errorWithDomain:[self ssah_server] code:SSErrorDomainEmptyData userInfo:@{@"msg":@"没有更多数据了"}];
                    }
                }
            }
            return data;
        } else {
            NSLog(@"\n服务器返回错误信息:\n%@\n",callback[@"status"]);
            return [NSError errorWithDomain:[self ssah_server] code:code userInfo:@{@"msg":callback[@"status"]}];
        }
    } else if (error){
        NSLog(@"\n\n\n请求失败:\n%@\n请求的参数:\n%@\n请求的地址:\n%@\n",error,params,requestURL.absoluteString);
        return error;
    } else {
        NSLog(@"\n\n\n返回数据为空:\n%@\n请求的参数:\n%@\n请求的地址:\n%@\n",error,params,requestURL.absoluteString);
        return [NSError errorWithDomain:[self ssah_server] code:SSErrorDomainUnknow userInfo:@{@"msg":@"未知错误"}];
    }
}

- (NSDictionary *)ssah_encryptParams:(NSDictionary *)params {
    return params;
}

- (SSPageTitleType)ssah_navigationTitleType {
    return SSPageTitleTypeLeft;
}

- (CGFloat)ssah_navigationbarItemsSpareSpace {
    return 10;
}

- (NSDictionary *)ssah_navigationTextAttributes {
    return @{NSForegroundColorAttributeName : [UIColor whiteColor],
             NSFontAttributeName : [UIFont systemFontOfSize:17]};
}

- (UIImage *)ssah_navigationBackgroundImage {
    return [[UIColor colorWithHexString:@"F95C64"] colorImage];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
