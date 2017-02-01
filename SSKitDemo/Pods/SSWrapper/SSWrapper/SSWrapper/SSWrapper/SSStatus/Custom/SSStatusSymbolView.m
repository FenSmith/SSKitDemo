//
//  SSStatusTypeView.m
//  SSStatusDemo
//
//  Created by Quincy Yan on 2017/1/27.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSStatusSymbolView.h"

#define SSSTATUS_SYMBOL_XFACTOR(x) x * _symbolViewSize.width / 50.0f
#define SSSTATUS_SYMBOL_YFACTOR(x) x * _symbolViewSize.height / 50.0f

@interface SSStatusSymbolView()
@property (nonatomic,strong) CAShapeLayer *statusLayer;

@end

@implementation SSStatusSymbolView

- (instancetype)initWithTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    self = [super initWithTouchCallback:callback isDisplayCallback:isDisplayCallback];
    if (!self) return nil;
    
    _symbolViewSize = CGSizeMake(25, 25);
    _strokeColor = [UIColor redColor];
    _strokeLineWidth = 3.0f;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer addSublayer:self.statusLayer];
    
    return self;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    _statusLayer.strokeColor = strokeColor.CGColor;
}

- (void)setStrokeLineWidth:(CGFloat)strokeLineWidth {
    _strokeLineWidth = strokeLineWidth;
    _statusLayer.lineWidth = strokeLineWidth;
}

- (void)setSymbolViewSize:(CGSize)symbolViewSize {
    _symbolViewSize = symbolViewSize;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat x = (CGRectGetWidth(self.frame) - _symbolViewSize.width) / 2;
    CGFloat y = (CGRectGetHeight(self.frame) - _symbolViewSize.height) / 2;
    
    _statusLayer.frame = CGRectMake(x, y, _symbolViewSize.width, _symbolViewSize.height);
    _statusLayer.path = [self statusSymbolViewPath];
}

- (CGPathRef)statusSymbolViewPath {
    CGFloat centerx = _symbolViewSize.width / 2;
    CGFloat centery = _symbolViewSize.height / 2;
    CGFloat r = _symbolViewSize.width / 2;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(centerx, 0)];
    [bezierPath addArcWithCenter:CGPointMake(centerx, centery) radius:r startAngle:- M_PI_2 endAngle:M_PI * 2 - M_PI_2 clockwise:YES];
    
    switch (_type) {
        case SSStatusViewTypeSymbolSuccess:{
            CGSize symbolSize = CGSizeMake(SSSTATUS_SYMBOL_XFACTOR(26), SSSTATUS_SYMBOL_YFACTOR(30));
            CGFloat x = (_symbolViewSize.width - symbolSize.width) / 2;
            CGFloat y = (_symbolViewSize.height - symbolSize.height) / 2;
            
            [bezierPath moveToPoint:CGPointMake(x, y + SSSTATUS_SYMBOL_YFACTOR(16))];
            [bezierPath addLineToPoint:CGPointMake(x + SSSTATUS_SYMBOL_XFACTOR(10), y + SSSTATUS_SYMBOL_YFACTOR(26))];
            [bezierPath addLineToPoint:CGPointMake(x + SSSTATUS_SYMBOL_XFACTOR(27), y + SSSTATUS_SYMBOL_YFACTOR(9))];
        }
            break;
        case SSStatusViewTypeSymbolError:{
            CGSize symbolSize = CGSizeMake(SSSTATUS_SYMBOL_XFACTOR(23), SSSTATUS_SYMBOL_XFACTOR(23));
            CGFloat x = (_symbolViewSize.width - symbolSize.width) / 2;
            CGFloat y = (_symbolViewSize.height - symbolSize.height) / 2;
            
            [bezierPath moveToPoint:CGPointMake(x, y)];
            [bezierPath addLineToPoint:CGPointMake(x + symbolSize.width, y + symbolSize.height)];
            [bezierPath moveToPoint:CGPointMake(x + symbolSize.width, y)];
            [bezierPath addLineToPoint:CGPointMake(x, y + symbolSize.height)];
        }
            break;
        case SSStatusViewTypeSymbolAlert:{
            CGSize symbolSize = CGSizeMake(SSSTATUS_SYMBOL_XFACTOR(35), SSSTATUS_SYMBOL_YFACTOR(35));
            CGFloat x = (_symbolViewSize.width - symbolSize.width) / 2;
            CGFloat y = (_symbolViewSize.height - symbolSize.height) / 2;
            
            CGFloat internalR = _statusLayer.lineWidth / 4;
            CGFloat acenterx = x + symbolSize.width / 2;
            
            [bezierPath moveToPoint:CGPointMake(acenterx, y + SSSTATUS_SYMBOL_YFACTOR(8))];
            [bezierPath addArcWithCenter:CGPointMake(acenterx, y + SSSTATUS_SYMBOL_YFACTOR(8)) radius:internalR startAngle:- M_PI_2 endAngle:M_PI * 2 - M_PI_2 clockwise:YES];
            [bezierPath moveToPoint:CGPointMake(acenterx, y + SSSTATUS_SYMBOL_YFACTOR(14) + internalR * 2)];
            [bezierPath addLineToPoint:CGPointMake(acenterx, y + SSSTATUS_SYMBOL_YFACTOR(30) + internalR * 2)];
        }
            break;
        default:
            break;
    }
    
    return bezierPath.CGPath;
}

- (void)statusSymbolViewReadyToAnimation {
    [_statusLayer addAnimation:[self statusViewAddAnimation] forKey:@"statusAnimation"];
}

- (CAShapeLayer *)statusLayer {
    if (!_statusLayer) {
        _statusLayer = [CAShapeLayer layer];
        _statusLayer.lineWidth = _strokeLineWidth;
        _statusLayer.fillColor = [UIColor clearColor].CGColor;
        _statusLayer.strokeColor = _strokeColor.CGColor;
    }
    return _statusLayer;
}

- (CABasicAnimation *)statusViewAddAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.duration = 1.0f;
    animation.repeatCount = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}

@end
