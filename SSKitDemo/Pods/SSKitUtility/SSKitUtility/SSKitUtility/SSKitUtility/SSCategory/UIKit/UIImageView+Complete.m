//
//  UIImageView+Complete.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/25.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIImageView+Complete.h"
#import <objc/runtime.h>
#import "NSArray+SSKit.h"

static NSString * const SSKit_ImageView_KeyPath = @"contents";

@implementation UIImageView (Complete)
static char SSKit_UIImageView_CompleteKey;

- (void)setCompleteHandler:(void (^)(BOOL flag))completeHandler {
    objc_setAssociatedObject(self, &SSKit_UIImageView_CompleteKey, completeHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())completeHandler {
    return objc_getAssociatedObject(self, &SSKit_UIImageView_CompleteKey);
}

- (void)startAnimatingWithCompleteHandler:(void (^)(BOOL))handler {
    [self startAnimatingWithImages:self.animationImages alsoCompleteHandler:handler];
}

- (void)startAnimatingWithImages:(NSArray *)images alsoCompleteHandler:(void (^)(BOOL flag))handler {
    if (handler) {
        self.completeHandler = handler;
    }
    
    NSArray *cgImages = [images objsMap:^id(UIImage *obj,NSInteger index) {
        return (id)obj.CGImage;
    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    [animation setKeyPath:SSKit_ImageView_KeyPath];
    [animation setValues:cgImages];
    [animation setRepeatCount:self.animationRepeatCount];
    [animation setDuration:self.animationDuration];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    CALayer *layer = self.layer;
    [layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.completeHandler) {
        self.completeHandler(flag);
    }
}

@end
