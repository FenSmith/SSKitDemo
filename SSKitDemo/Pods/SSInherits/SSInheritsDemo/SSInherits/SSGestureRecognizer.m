//
//  SSGestureRecognizer.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation SSGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateBegan;
    _startPoint = [(UITouch *)[touches anyObject] locationInView:self.view];
    _endPoint = _currentPoint;
    _currentPoint = _startPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    self.state = UIGestureRecognizerStateChanged;
    _currentPoint = currentPoint;
    _endPoint = _currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateEnded;
}

@end
