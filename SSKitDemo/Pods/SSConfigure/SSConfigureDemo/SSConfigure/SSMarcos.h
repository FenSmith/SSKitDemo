//
//  SSMarcos.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#ifndef SSMarcos_h
#define SSMarcos_h

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds

#define DEVICE_LANDSCAPE  ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || \
[UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)

#define DEVICE_IPAD             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define DEVICE_IPHONE           ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4       (DEVICE_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define IS_IPHONE5       (DEVICE_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE6       (DEVICE_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE6PLUS   (DEVICE_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)

#endif /* SSMarcos_h */
