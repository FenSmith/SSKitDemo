//
//  SSAppHandler.m
//  SSKit
//
//  Created by Quincy Yan on 16/1/1.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSAppHandler.h"

@implementation SSAppHandler

+ (SSAppHandler *)sharedHander {
    static SSAppHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[SSAppHandler alloc] init];
    });
    return handler;
}

- (NSString *)server {
    return [self.delegate ssah_server];
}

- (NSDictionary *)ssah_HTTPHeaderFields {
    if ([self.delegate respondsToSelector:@selector(ssah_HTTPHeaderFields)]) {
        return [self.delegate ssah_HTTPHeaderFields];
    }
    return @{};
}

- (id)ssah_filterCallback:(id)callback error:(NSError *)error params:(NSDictionary *)params requestURL:(NSURL *)requestURL {
    if ([self.delegate respondsToSelector:@selector(ssah_handleServerCallback:error:params:requestURL:)]) {
        return [self.delegate ssah_handleServerCallback:callback error:error params:params requestURL:requestURL];
    }
    return callback;
}

- (NSDictionary *)ssah_encryptParams:(NSDictionary *)params {
    if ([self.delegate respondsToSelector:@selector(ssah_encryptParams:)]) {
        return [self.delegate ssah_encryptParams:params];
    }
    return params;
}

- (UIImage *)navigationBackgroundImage {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationBackgroundImage)]) {
        return [self.delegate ssah_navigationBackgroundImage];
    }
    return [UIImage new];
}

- (NSDictionary *)navigationTextAttributes {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationTextAttributes)]) {
        return [self.delegate ssah_navigationTextAttributes];
    }
    return @{NSForegroundColorAttributeName : [UIColor blackColor],
             NSFontAttributeName : [UIFont systemFontOfSize:17]};
}

- (UIImage *)navigationbarImage {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationbarImage)]) {
        return [self.delegate ssah_navigationbarImage];
    }
    return [UIImage imageWithCGImage:[UIImage imageNamed:@"SSKIT_NAVIBAR_RETURN"].CGImage scale:3.0f orientation:UIImageOrientationUp];
}

- (UIImage *)navigationbarHighlightImage {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationbarHighlightImage)]) {
        return [self.delegate ssah_navigationbarHighlightImage];
    } else if ([self.delegate respondsToSelector:@selector(ssah_navigationbarImage)]) {
        return [self.delegate ssah_navigationbarImage];
    }
    return [UIImage imageWithCGImage:[UIImage imageNamed:@"SSKIT_NAVIBAR_RETURN2"].CGImage scale:3.0f orientation:UIImageOrientationUp];
}

- (UIImage *)navigationbarShadowImage {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationbarShadowImage)]) {
        return [self.delegate ssah_navigationbarShadowImage];
    }
    return [UIImage new];
}

- (SSPageTitleType)navigationTitleType {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationTitleType)]) {
        return [self.delegate ssah_navigationTitleType];
    }
    return SSPageTitleTypeCenter;
}

- (CGFloat)navigationbarItemsSpareSpace {
    if ([self.delegate respondsToSelector:@selector(ssah_navigationbarItemsSpareSpace)]) {
        return [self.delegate ssah_navigationbarItemsSpareSpace];
    }
    return 0;
}

- (UIColor *)webProgressIndicatorColor {
    if ([self.delegate respondsToSelector:@selector(ssah_webProgressIndicatorColor)]) {
        return [self.delegate ssah_webProgressIndicatorColor];
    }
    return [UIColor blackColor];
}

@end
