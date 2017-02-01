//
//  SSWebProgressView.m
//  SSWrapper
//
//  Created by Quincy Yan on 2017/1/30.
//  Copyright © 2017年 Quincy Yan. All rights reserved.
//

#import "SSWebProgressView.h"

@interface SSWebProgressView()

/**
 第一阶段速度变化时的最大进度
 */
@property (nonatomic,assign) CGFloat firstPhaseValue;

/**
 在加载结束前所能达到的最大进度
 */
@property (nonatomic,assign) CGFloat secondPhaseValue;

@property (nonatomic,strong) CADisplayLink *progressTimer;

@end

@implementation SSWebProgressView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self _internalConfigure];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self _internalConfigure];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self _internalConfigure];
    return self;
}

- (void) _internalConfigure {
    self.backgroundColor = [UIColor clearColor];
    
    _firstPhaseValue = 0.6f;
    _secondPhaseValue = 0.9f;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self removeDisplayLink];
}

- (void)webViewReadyToLoading {
    [self removeDisplayLink];
    
    self.value = 0.0f;
    
    _progressTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(viewProgressAction)];
    [_progressTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)webViewFinishLoading {
    [self removeDisplayLink];
    
    _progressTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(viewFinishAction)];
    [_progressTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)viewProgressAction {
    if (self.value >= _firstPhaseValue && self.value < _secondPhaseValue) {
        self.value += 0.001f;
    } else {
        self.value += 0.002f;
    }
    
    if (self.value >= _secondPhaseValue) {
        [self removeDisplayLink];
    }
}

- (void)viewFinishAction {
    self.value += 0.02f;
    
    if (self.value >= 1.0f) {
        [self removeDisplayLink];
    }
}

- (void)removeDisplayLink {
    if (_progressTimer) {
        [_progressTimer invalidate]; _progressTimer = nil;
    }
}

@end
