//
//  SSStatusView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSStatusView : UIView

@property (nonatomic,copy) BOOL (^ statusViewTapCallback)();
@property (nonatomic,copy) void (^ statusViewTapHandler)();

- (void)resetImage:(UIImage *)image alsoTitle:(NSString *)title;

@end
