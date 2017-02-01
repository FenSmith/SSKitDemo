//
//  SSStatusBaseView.m
//  SSStatusDemo
//
//  Created by Quincy Yan on 2017/1/27.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSStatusBaseView.h"

@implementation SSStatusBaseView

- (instancetype)initWithTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    self = [super init];
    if (!self) return nil;
    
    self.touchCallback = callback;
    self.removeVerifyCallback = isDisplayCallback;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesActionHandler)];
    [self addGestureRecognizer:ges];
    [self setUserInteractionEnabled:YES];
    
    return self;
}

- (void)gesActionHandler {
    if (self.removeVerifyCallback && !self.removeVerifyCallback()) {
        [self removeFromSuperview];
    }
    
    if (self.touchCallback) {
        self.touchCallback(self);
    }
}

@end
