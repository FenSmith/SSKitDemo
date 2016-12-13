//
//  UIImageView+Complete.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/25.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Complete)

- (void)startAnimatingWithCompleteHandler:(void (^)(BOOL completeFlag))handler;

@end
