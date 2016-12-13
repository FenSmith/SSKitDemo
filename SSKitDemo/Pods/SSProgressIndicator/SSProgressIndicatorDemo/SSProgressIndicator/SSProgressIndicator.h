//
//  SSProgressIndicator.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/17.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSProgressIndicator : UIView

@property (nonatomic,strong) UIColor *strokeColor; ///> default to blackColor
@property (nonatomic) BOOL hiddenWhenStoped; ///> default to yes

- (void)startAnimating;
- (void)stopAnimating;

@end
