//
//  SSStarReloadView.m
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSStarReloadView.h"

#define ANGLE2RADIAN(a) M_PI * a / 180

@interface SSStarReloadView() {
    CGFloat _rate;
    UIBezierPath *_bezier;
}

@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@end

@implementation SSStarReloadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self _starReloadViewInitialize];
    
    [self.layer addSublayer:self.shapeLayer];
    [self resetShapeLayerFrame];
    
    return self;
}

- (void)_starReloadViewInitialize {
    _position = SSStarPositionLeft;
    _scale = 0.5f;
    _lineWidth = 2.0f;
    _starFillColor = [self starColor];
    _starStrokeColor = [self starFillColor];
    _pOffset = CGPointMake(0, 0);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self resetShapeLayerFrame];
}

- (void)stateWillChangeWithType:(SSRefreshState)state {
    switch (state) {
        case SSRefreshStateInitial:{
            _shapeLayer.fillColor = [UIColor clearColor].CGColor;
            [_shapeLayer removeAllAnimations];
        }
            break;
        case SSRefreshStatePulling:{
            
        }
            break;
        case SSRefreshStateRefreshing:{
            _shapeLayer.fillColor = _starFillColor.CGColor;
            [_shapeLayer addAnimation:[self insertCirclingAnimation] forKey:@"rotation"];
        }
            break;
        default:
            break;
    }
}

- (void)offsetWillChangeWithValue:(CGFloat)offset withPercent:(CGFloat)percent {
    if (_rate == percent) return;
    
    _rate = percent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    _shapeLayer.path = [self starPathShouldReload:NO];
    _shapeLayer.strokeStart = 0.0f;
    _shapeLayer.strokeEnd = _rate;
}

- (CGPathRef)starPathShouldReload:(BOOL)shouldReload {
    if (_bezier && !shouldReload) return _bezier.CGPath;

    CGFloat r = [self r];
    CGFloat rr = r / 2;
    
    CGPoint a = CGPointMake(0, r);
    CGPoint b = CGPointMake(cosf(ANGLE2RADIAN(18)) * r, sinf(ANGLE2RADIAN(18)) * r);
    CGPoint c = CGPointMake(cosf(ANGLE2RADIAN(54)) * r, -sinf(ANGLE2RADIAN(54)) * r);
    CGPoint d = CGPointMake(-cosf(ANGLE2RADIAN(54)) * r, -sinf(ANGLE2RADIAN(54)) * r);
    CGPoint e = CGPointMake(-cosf(ANGLE2RADIAN(18)) * r, sinf(ANGLE2RADIAN(18)) * r);
    
    CGPoint aa = CGPointMake(0, -rr);
    CGPoint bb = CGPointMake(-cosf(ANGLE2RADIAN(18)) * rr, -sinf(ANGLE2RADIAN(18)) * rr);
    CGPoint cc = CGPointMake(-cosf(ANGLE2RADIAN(54)) * rr, sinf(ANGLE2RADIAN(54)) * rr);
    CGPoint dd = CGPointMake(cosf(ANGLE2RADIAN(54)) * rr, sinf(ANGLE2RADIAN(54)) * rr);
    CGPoint ee = CGPointMake(cosf(ANGLE2RADIAN(18)) * rr, -sinf(ANGLE2RADIAN(18)) * rr);
    
    NSArray *array = @[[NSValue valueWithCGPoint:a],
                       [NSValue valueWithCGPoint:dd],
                       [NSValue valueWithCGPoint:b],
                       [NSValue valueWithCGPoint:ee],
                       [NSValue valueWithCGPoint:c],
                       [NSValue valueWithCGPoint:aa],
                       [NSValue valueWithCGPoint:d],
                       [NSValue valueWithCGPoint:bb],
                       [NSValue valueWithCGPoint:e],
                       [NSValue valueWithCGPoint:cc]];
    
    _bezier = [UIBezierPath bezierPath];
    for (int i = 0; i < array.count + 1; i++) {
        NSValue *value = i == array.count ? [array objectAtIndex:0] : [array objectAtIndex:i];
        CGPoint point = value.CGPointValue;
        CGFloat x = r + point.x;
        CGFloat y = r - point.y;

        if (i == 0) {
            [_bezier moveToPoint:CGPointMake(x, y)];
        } else {
            [_bezier addLineToPoint:CGPointMake(x, y)];
        }
    }
    return _bezier.CGPath;
}

- (CGFloat)r {
    return CGRectGetHeight(self.frame) / 2 / 2 * _scale;
}

- (UIColor *)starColor {
    return [UIColor colorWithRed:242.0f/255.0f green:202.0/255.0f blue:72.0f/255.0f alpha:1.0f];
}

- (void)setScale:(CGFloat)scale {
    if (_scale != scale) {
        _scale = scale;
        [self starPathShouldReload:YES];
        [self resetShapeLayerFrame];
    }
    _scale = scale;
}

- (void)setPosition:(SSStarPosition)position {
    if (_position != position) {
        _position = position;
        [self starPathShouldReload:YES];
        [self resetShapeLayerFrame];
    }
    _position = position;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth > 0.0f) {
        _lineWidth = lineWidth;
        _shapeLayer.lineWidth = lineWidth;
    }
}

- (void)setPOffset:(CGPoint)pOffset {
    if (!CGPointEqualToPoint(pOffset, _pOffset)) {
        _pOffset = pOffset;
        [self resetShapeLayerFrame];
    }
}

- (void)resetShapeLayerFrame {
    CGFloat r = [self r];
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    CGFloat x = 0;
    CGFloat y = (h - 2 * r) / 2;
    switch (_position) {
        case SSStarPositionLeft:{
            x = w * 0.1f;
        }
            break;
        case SSStarPositionCenter:{
            x = w / 2 - r;
        }
            break;
        case SSStarPositionRight:{
            x = w - r * 2 - w * 0.1f;
        }
            break;
        default:
            break;
    }
    _shapeLayer.frame = CGRectMake(x + _pOffset.x, y + _pOffset.y, 2 * r, 2 * r);
}

- (CABasicAnimation *)insertCirclingAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.duration = 1.0f;
    animation.repeatCount = MAXFLOAT;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return animation;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = _lineWidth;
        _shapeLayer.strokeColor = _starStrokeColor.CGColor;
        _shapeLayer.lineCap = kCALineCapRound;
    }
    return _shapeLayer;
}

@end
