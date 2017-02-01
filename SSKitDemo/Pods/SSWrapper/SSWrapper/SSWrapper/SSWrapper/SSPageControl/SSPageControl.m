//
//  SSPageControl.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSPageControl.h"

@implementation SSPageControl

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    _currentPageIndicatorColor = [UIColor grayColor];
    _othersPageIndicatorColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
    _sizeForPageIndicator = CGSizeMake(8, 8);
    _pageItemPadding = 10;
    
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGSize size = _sizeForPageIndicator;
    
    CGFloat x = (w - size.width * _numbersOfPages - _pageItemPadding * (_numbersOfPages - 1)) / 2;
    CGFloat y = h / 2;
    
    for (int i = 0; i < _numbersOfPages; i++) {
        switch (_type) {
            case SSPageControlTypeCircle: {
                CGContextMoveToPoint(context, x + (size.width + _pageItemPadding) * i + size.width / 2, y);
                CGContextAddArc(context, x + (size.width + _pageItemPadding) * i + size.width / 2, y, size.width / 2, 0, M_PI * 2, NO);
                CGContextSetFillColorWithColor(context, i == _currentPage ? _currentPageIndicatorColor.CGColor : _othersPageIndicatorColor.CGColor);
                CGContextDrawPath(context, kCGPathFill);
            }
                break;
            case SSPageControlTypeRect: {
                CGRect frame = CGRectMake(x + i * (size.width + _pageItemPadding),
                                          y - size.height / 2,
                                          size.width,
                                          size.height);
                CGContextSetFillColorWithColor(context, i == _currentPage ? _currentPageIndicatorColor.CGColor : _othersPageIndicatorColor.CGColor);
                CGContextStrokeRect(context,frame);
                CGContextFillRect(context, frame);
            }
                break;
            default:
                break;
        }
    }
    
    CGContextStrokePath(context);
}

@end
