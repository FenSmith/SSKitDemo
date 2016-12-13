//
//  HZWaveView.h
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/27.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTBWaveView : UIView

@property (nonatomic) CGFloat startX;
@property (nonatomic) CGFloat amplitude; // 波幅
@property (nonatomic) CGFloat velocity; // 速度

- (void)startWaveAnimating;

@end
