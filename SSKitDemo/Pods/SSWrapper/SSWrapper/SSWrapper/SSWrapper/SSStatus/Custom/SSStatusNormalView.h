//
//  SSStatusView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSStatusBaseView.h"

@interface SSStatusNormalView : SSStatusBaseView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *textLabel;

- (void)resetStatusViewWithImage:(UIImage *)image title:(NSString *)title;

@end
