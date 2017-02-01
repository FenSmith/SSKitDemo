//
//  SSDialog.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSDialog.h"

static CGFloat SSDialogMaxWidth = 182;
static CGFloat SSDialogMinWidth = 182;
static CGFloat SSDialogMinHeight = 85;
static CGFloat SSDialogIconWidth = 30;
static CGFloat SSDialogIconHeight = 30;

@interface SSDialog()
@property (nonatomic,strong) UIView *dialogView;
@property (nonatomic,strong) UIView *contextView;
@property (nonatomic,strong) CAShapeLayer *slayer;
@property (nonatomic,strong) UIActivityIndicatorView *idcView;

@end

@implementation SSDialog

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.topInsets = UIEdgeInsetsMake(14, 15, 14, 15);
    self.detailInsets = UIEdgeInsetsMake(14, 15, 17, 15);

    [self addSubview:self.contextView];
    [self addSubview:self.dialogView];
    
    [self.dialogView addSubview:self.idcView];
    [self.dialogView.layer addSublayer:self.slayer];
    [self.dialogView addSubview:self.detailLabel];
    
    return self;
}

- (void)show {
    [self showInView:nil];
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [view addSubview:self];
    [self.contextView setFrame:view.bounds];
    
    CGFloat topTotal = 0;
    // 高度不含edgeInsets
    // 如果str为空 则返回默认最小宽高
    CGSize detailTotal = [self detailSize];
    
    if (self.type != SSDialogTypeNone) {
        topTotal = SSDialogIconHeight + self.topInsets.top + self.topInsets.bottom;
    }
    
    if (topTotal != 0) {
        CGFloat detailw = detailTotal.width;
        CGRect rect = CGRectMake(((detailw == 0.0f ? SSDialogMinWidth : detailw + self.detailInsets.left + self.detailInsets.right) - SSDialogIconWidth) / 2,
                                 detailw == 0.0f ? (SSDialogMinHeight - SSDialogIconHeight) / 2 : self.topInsets.top,
                                 SSDialogIconWidth,
                                 SSDialogIconHeight);
        if (self.idcView.isAnimating) {
            [self.idcView stopAnimating];
        }
        
        switch (self.type) {
            case SSDialogTypeCorrect:{
                [self.slayer setFrame:rect];
                self.slayer.path = [self bezierPathForCorrectSymbolWithLayerRect:rect alsoLineW:2.5f].CGPath;
            }
                break;
            case SSDialogTypeWrong:{
                [self.slayer setFrame:rect];
                self.slayer.path = [self bezierPathForWrongSymbolWithLayerRect:rect alsoLineW:2.0f].CGPath;
            }
                break;
            case SSDialogTypeAlert:{
                [self.slayer setFrame:rect];
                self.slayer.path = [self bezierPathForAlertSymbolWithLayerRect:rect alsoLineW:2.0f].CGPath;
            }
                break;
            case SSDialogTypeWait:{
                [self.idcView setFrame:rect];
                [self.idcView startAnimating];
            }
                break;
            case SSDialogTypeWaitCover:{
                [self.idcView setFrame:rect];
                [self.idcView startAnimating];
            }
                break;
                
            default:
                break;
        }
    }
    
    if (!CGSizeEqualToSize(detailTotal, CGSizeZero)) {
        CGFloat detaily = topTotal + self.detailInsets.top;
        if (topTotal != 0.0f) {
            detaily = topTotal;
        }
        
        if (detailTotal.height + self.detailInsets.top + self.detailInsets.bottom + topTotal < SSDialogMinHeight) {
            detaily = (SSDialogMinHeight - detailTotal.height) / 2;
        }
        
        [self.detailLabel setFrame:CGRectMake(self.detailInsets.left,
                                              detaily,
                                              detailTotal.width,
                                              detailTotal.height)];
    }
    
    CGFloat dialogw = detailTotal.width + self.detailInsets.left + self.detailInsets.right;
    if (dialogw < SSDialogMinWidth) {
        dialogw = SSDialogMinWidth;
    }
    
    CGFloat dialogh = topTotal + self.detailInsets.top + self.detailInsets.bottom + detailTotal.height;
    if (topTotal != 0.0f) {
        dialogh -= self.detailInsets.top;
    }
    if (dialogh < SSDialogMinHeight) {
        dialogh = SSDialogMinHeight;
    }
    
    [self.dialogView setFrame:CGRectMake((CGRectGetWidth(view.frame) - dialogw) / 2,
                                         (CGRectGetHeight(view.frame) - dialogh) / 2,
                                         dialogw,
                                         dialogh)];
    if (self.type != SSDialogTypeWaitCover) {
        [self setFrame:self.dialogView.frame];
        [self.dialogView setFrame:self.bounds];
    } else {
        [self setFrame:view.bounds];
    }
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0);
    self.contextView.layer.opacity = 0.0f;
    [UIView animateWithDuration:0.15f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.dialogView.layer.opacity = 1.0f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                         if (self.type == SSDialogTypeWaitCover) {
                             self.contextView.layer.opacity = 0.4f;
                         }
                     }
                     completion:NULL
     ];
    
    self.autoHiddenTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoHiddenTimeInterval
                                                            target:self
                                                          selector:@selector(autoHiddenTimerCallback)
                                                          userInfo:nil repeats:NO];
}

- (void)autoHiddenTimerCallback {
    [self close];

    if (self.callback) {
        self.callback();
    }
}

- (void)close {
    CATransform3D currentTransform = self.dialogView.layer.transform;
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.dialogView.layer.opacity = 0.0f;
                         self.contextView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

- (CGSize)detailSize {
    NSString *str = self.detailLabel.text;
    if (str && str.length > 0) {
        CGSize sizeMin = [self.detailLabel sizeThatFits:CGSizeMake(SSDialogMinWidth - (self.detailInsets.left + self.detailInsets.right), MAXFLOAT)];
        if (sizeMin.width + self.detailInsets.left + self.detailInsets.right > SSDialogMinWidth) {
            return [self.detailLabel sizeThatFits:CGSizeMake(SSDialogMaxWidth - (self.detailInsets.left + self.detailInsets.right), MAXFLOAT)];
        }
        return CGSizeMake(SSDialogMinWidth - self.detailInsets.left - self.detailInsets.right, sizeMin.height);
    }
    return CGSizeZero;
}

- (UIBezierPath *)bezierPathForCorrectSymbolWithLayerRect:(CGRect)rect alsoLineW:(CGFloat)lineW {
    CGSize symbolSize = CGSizeMake(22, 28);
    
    CGFloat x = (rect.size.width - symbolSize.width) / 2;
    CGFloat y = (rect.size.height - symbolSize.height) / 2;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(x, y + 16)];
    [bezierPath addLineToPoint:CGPointMake(x + 7, y + 23)];
    [bezierPath addLineToPoint:CGPointMake(x + 21, y + 9)];
    [bezierPath addLineToPoint:CGPointMake(x + 21 - lineW / 2, y + 9 - lineW / 2)];
    [bezierPath addLineToPoint:CGPointMake(x + 7, y + 23 - lineW)];
    [bezierPath addLineToPoint:CGPointMake(x + lineW / 2, y + 16 - lineW / 2)];
    [bezierPath closePath];
    
    return bezierPath;
}

- (UIBezierPath *)bezierPathForWrongSymbolWithLayerRect:(CGRect)rect alsoLineW:(CGFloat)lineW {
    CGSize symbolSize = CGSizeMake(13, 13);
    
    CGFloat oriX = (rect.size.width - symbolSize.width) / 2;
    CGFloat oriY = (rect.size.height - symbolSize.height) / 2;
    
    CGFloat marginX = lineW / sqrt(2.0);
    CGFloat marginY = marginX;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(oriX, oriY + marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + marginX, oriY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2, oriY + symbolSize.height / 2 - marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width - marginX, oriY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width, oriY + marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 + marginX, oriY + symbolSize.height / 2)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width, oriY + symbolSize.height - marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width - marginX, oriY + symbolSize.height)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2, oriY + symbolSize.height / 2 + marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + marginX, oriY + symbolSize.height)];
    [bezierPath addLineToPoint:CGPointMake(oriX, oriY + symbolSize.height - marginY)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 - marginX, oriY + symbolSize.height / 2)];
    [bezierPath closePath];
    
    return bezierPath;
}

- (UIBezierPath *)bezierPathForAlertSymbolWithLayerRect:(CGRect)rect alsoLineW:(CGFloat)lineW{
    CGSize symbolSize = CGSizeMake(22, 24);
    
    CGFloat oriX = (rect.size.width - symbolSize.width) / 2;
    CGFloat oriY = (rect.size.height - symbolSize.height) / 2;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(oriX + symbolSize.width / 2, oriY)];
    [bezierPath addArcWithCenter:CGPointMake(oriX + symbolSize.width / 2, oriY + 6) radius:lineW startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [bezierPath moveToPoint:CGPointMake(oriX + symbolSize.width / 2 - lineW / 2, oriY + 11)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 + lineW / 2, oriY + 11)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 + lineW / 2, oriY + 11 + 10)];
    [bezierPath addLineToPoint:CGPointMake(oriX + symbolSize.width / 2 - lineW / 2, oriY + 11 + 10)];
    [bezierPath closePath];
    
    return bezierPath;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.autoHiddenTimer) {
        [self.autoHiddenTimer invalidate]; self.autoHiddenTimer = nil;
        [self close];
    }
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIView *)dialogView {
    if (!_dialogView) {
        _dialogView = [[UIView alloc] init];
        _dialogView.backgroundColor = [UIColor blackColor];
        [_dialogView.layer setCornerRadius:6.0f];
    }
    return _dialogView;
}

- (CAShapeLayer *)slayer {
    if (!_slayer) {
        _slayer = [CAShapeLayer layer];
        _slayer.borderWidth = 2.0f;
        _slayer.fillColor = [UIColor whiteColor].CGColor;
        _slayer.borderColor = [UIColor whiteColor].CGColor;
        _slayer.cornerRadius = SSDialogIconWidth / 2;
        _slayer.strokeColor = [UIColor clearColor].CGColor;
        [_slayer setStrokeEnd:0.0];
    }
    return _slayer;
}

- (UIView *)contextView {
    if (!_contextView) {
        _contextView = [[UIView alloc] init];
        _contextView.backgroundColor = [UIColor blackColor];
    }
    return _contextView;
}

- (UIActivityIndicatorView *)idcView {
    if (!_idcView) {
        _idcView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _idcView;
}

@end
