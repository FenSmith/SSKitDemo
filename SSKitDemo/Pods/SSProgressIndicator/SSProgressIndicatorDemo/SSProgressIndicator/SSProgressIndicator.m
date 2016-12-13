//
//  SSProgressIndicator.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/17.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSProgressIndicator.h"

static CGFloat const unfinishedMaxTimeProgress = 0.8f;
static NSTimeInterval const maxTimeInterval = 4 * 60.0f;

@interface SSProgressIndicator()
@property (nonatomic) NSTimeInterval progressingTimeInterval;
@property (nonatomic,strong) CADisplayLink *progressingTimer;
@property (nonatomic,strong) CADisplayLink *finishedTimer;

@end

@implementation SSProgressIndicator

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    self.strokeColor = [UIColor blackColor];
    self.hiddenWhenStoped = YES;
    
    return self;
}

- (void)startAnimating {
    if (self.progressingTimer || self.finishedTimer) {
        return ;
    }
    
    self.progressingTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressingCallback)];
    [self.progressingTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)progressingCallback {
    self.progressingTimeInterval ++;
    
    if (self.progressingTimeInterval > maxTimeInterval * unfinishedMaxTimeProgress) {
        [self.progressingTimer invalidate]; self.progressingTimer = nil;
    } else {
        [self setNeedsDisplay];
    }
}

- (void)stopAnimating {
    if (self.finishedTimer) {
        return;
    }
    
    self.finishedTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(finishedCallback)];
    [self.finishedTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.finishedTimer.frameInterval = 0.5f;
}

- (void)finishedCallback {
    self.progressingTimeInterval ++;
    
    if (self.progressingTimeInterval > maxTimeInterval) {
        [self.finishedTimer invalidate]; self.finishedTimer = nil;
        if (self.hiddenWhenStoped) {
            [self removeFromSuperview];
        }
        
    } else {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, CGRectGetHeight(self.frame));
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    
    CGFloat progress = (float)self.progressingTimeInterval / (float)maxTimeInterval;
    
    CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame) / 2);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) * progress, CGRectGetHeight(self.frame) / 2);
    CGContextStrokePath(context);
}

@end
