//
//  SSDialog.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SSDialogType) {
    SSDialogTypeNone = 0,
    SSDialogTypeCorrect = 1,
    SSDialogTypeWrong = 2,
    SSDialogTypeAlert = 3,
    SSDialogTypeWait = 4,
    SSDialogTypeWaitCover = 5,
};

typedef void (^ ssdl_timerFinishCallback)();

@interface SSDialog : UIView

@property (nonatomic) SSDialogType type;
@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic) UIEdgeInsets topInsets;
@property (nonatomic) UIEdgeInsets detailInsets;

@property (nonatomic) NSTimeInterval autoHiddenTimeInterval; ///> 默认2秒
@property (nonatomic,strong) NSTimer *autoHiddenTimer;
@property (nonatomic,copy) ssdl_timerFinishCallback callback;

- (void)show;
- (void)showInView:(UIView *)view;
- (void)close;

@end
