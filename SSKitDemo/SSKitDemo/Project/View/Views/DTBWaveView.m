//
//  HZWaveView.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/27.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBWaveView.h"

@interface DTBWaveView()
@property (nonatomic) CGFloat progress;
@property (nonatomic,strong) CADisplayLink *displayTimer;

@end

@implementation DTBWaveView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0.2f;
    self.amplitude = 10.0f;
    self.velocity = 1.0f;
    
    return self;
}

- (void)displayCallback {
    self.progress += self.velocity;
    [self setNeedsDisplay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.displayTimer invalidate]; self.displayTimer = nil;
}

- (void)startWaveAnimating {
    self.displayTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayCallback)];
    [self.displayTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.displayTimer.frameInterval = 8;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [[UIColor whiteColor] set];
    
    CGSize size = self.frame.size;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:1.0f];
    
    [path moveToPoint:CGPointMake(0, size.height)];
    [path addLineToPoint:CGPointMake(0, size.height / 2)];
    for (int i = 0; i <= size.width; i++) {
        NSInteger index = (int)(i + self.progress) % 360 + self.startX;
        CGFloat angle = ((float)index / 360) * (M_PI * 2);
        CGFloat y = sinf(angle) * self.amplitude + size.height / 2;
        [path addLineToPoint:CGPointMake(i, y)];
    }
    
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    [path addLineToPoint:CGPointMake(0, size.height)];
    [path fill];
}

@end
