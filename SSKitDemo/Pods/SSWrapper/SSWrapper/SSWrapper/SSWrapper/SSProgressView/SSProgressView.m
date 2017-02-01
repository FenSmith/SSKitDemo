//
//  SSProgressView.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/17.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSProgressView.h"

@interface SSProgressView()
@end

@implementation SSProgressView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self _internalConfiguration];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self _internalConfiguration];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self _internalConfiguration];
    return self;
}

- (void) _internalConfiguration {
    self.backgroundColor = [UIColor clearColor];
    
    _fillColor = [UIColor colorWithRed:77.0f / 255.0f green:169.0f / 255.0f blue:52.0f / 255.0f alpha:1.0f];
    _hiddenWhenStoped = YES;
}

- (void)setValue:(CGFloat)value {
    if (_value == value) return;
    _value = value;

    [self setHidden:(_value >= 1.0f && _hiddenWhenStoped)];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, CGRectGetHeight(self.frame));
    CGContextSetStrokeColorWithColor(context, _fillColor.CGColor);
    CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame) / 2);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) * _value, CGRectGetHeight(self.frame) / 2);
    CGContextStrokePath(context);
}

@end
