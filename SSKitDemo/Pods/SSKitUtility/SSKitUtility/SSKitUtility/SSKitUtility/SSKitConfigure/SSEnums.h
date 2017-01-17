//
//  SSEnums.h
//  SSKit
//
//  Created by Quincy Yan on 16/9/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#ifndef SSEnums_h
#define SSEnums_h

typedef NS_ENUM(NSInteger,SSPageRouterShowType) {
    SSPageRouterShowTypePush = 0,
    SSPageRouterShowTypePresent = 1,
    SSPageRouterShowTypeReset = 2,
};

typedef NS_ENUM(NSInteger,SSPageTitleType) {
    SSPageTitleTypeCenter = 0, // 标题在正中央
    SSPageTitleTypeLeft = 1, // 标题在左 例: < 首页
    SSPageTitleTypeLeftOnlyTitle = 2, // 标题在左 但是没有箭头
};

#endif /* SSEnums_h */
