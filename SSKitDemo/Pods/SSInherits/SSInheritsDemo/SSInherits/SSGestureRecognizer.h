//
//  SSGestureRecognizer.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSGestureRecognizer : UIGestureRecognizer

@property (nonatomic, readonly) CGPoint startPoint;
@property (nonatomic, readonly) CGPoint endPoint;
@property (nonatomic, readonly) CGPoint currentPoint;

@end
