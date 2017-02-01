//
//  SSAlertView.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/3.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSAlertView.h"
#import "SSAlertViewConfig.h"
#import "UIColor+SSAlertView.h"
#import "NSString+SSAlertView.h"

static const CGFloat SSAlertViewContentMaxLength = 260;

static const CGFloat SSAlertViewTitleFont = 16;
static const CGFloat SSAlertViewContentFont = 14;

static const CGFloat SSAlertViewOptMargin = 10;
static const CGFloat SSAlertViewOptMinHeight = 47;
static const CGFloat SSAlertViewOptDistance = 0.5f;

NSString * const SSAlertViewOptFont = @"SSAlertViewOptFontName";
NSString * const SSAlertViewOptNormalTextColor = @"SSAlertViewOptNormalTextColorName";
NSString * const SSAlertViewOptDisableTextColor = @"SSAlertViewOptDisableTextColorName";
NSString * const SSAlertViewOptHighlightTextColor = @"SSAlertViewOptHighlightTextColorName";
NSString * const SSAlertViewOptNormalBackgroundColor = @"SSAlertViewOptNormalBackgroundColorName";
NSString * const SSAlertViewOptDisableTextBackgroundColor = @"SSAlertViewOptDisableTextBackgroundColorName";
NSString * const SSAlertViewOptHighlightBackgroundColor = @"SSAlertViewOptHighlightBackgroundColorName";

@interface SSAlertView()
@property (nonatomic, strong) UIView *spliter;
@property (nonatomic, strong) UIView *optsView;
@property (nonatomic, strong) NSTimer *delayTimer;
@property (nonatomic) BOOL isAlertViewHorizontal;
@property (nonatomic) CGFloat top,middle,bottom;

@end

@implementation SSAlertView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    [self resetAllParams];
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.cancelStr = @"取消";
    return self;
}

- (void)resetAllParams {
    self.titleInsets = UIEdgeInsetsMake(21, 20, 12, 20);
    self.contentInsets = UIEdgeInsetsMake(14, 20, 14, 20);
    
    self.optHeight = SSAlertViewOptMinHeight;
    self.optMaxWidth = SSAlertViewContentMaxLength;
    self.isAlertViewHorizontal = NO;
    self.isAlertViewTapToClose = NO;
    
    self.optAttributes = [[NSMutableDictionary alloc] initWithDictionary:@{SSAlertViewOptFont : [SSAlertViewConfig ssav_normalOptFont],
                                                                           SSAlertViewOptNormalTextColor : [SSAlertViewConfig ssav_normalOptTextColor],
                                                                           SSAlertViewOptNormalBackgroundColor : [SSAlertViewConfig ssav_normalOptBackgroundColor],
                                                                           SSAlertViewOptHighlightBackgroundColor : [SSAlertViewConfig ssav_normalOptHighlightBackgroundColor]}];
    
    self.cancelAttributes = [[NSMutableDictionary alloc] initWithDictionary:@{SSAlertViewOptFont : [SSAlertViewConfig ssav_cancelOptFont],
                                                                              SSAlertViewOptNormalTextColor : [SSAlertViewConfig ssav_cancelOptTextColor],
                                                                              SSAlertViewOptNormalBackgroundColor : [SSAlertViewConfig ssav_cancelOptBackgroundColor],
                                                                              SSAlertViewOptHighlightBackgroundColor : [SSAlertViewConfig ssav_cancelOptHighlightBackgroundColor]}];
}

- (void)showActivityIndicatorWithTimeInterval:(NSTimeInterval)afterTime {
    [self.activityView startAnimating];
    self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:afterTime target:self selector:@selector(delayTimerHandler) userInfo:nil repeats:NO];
}

- (void)delayTimerHandler {
    [self.activityView stopAnimating];
}

- (void)show {
    [self showInView:nil];
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    
    [self addSubview:self.contextView];
    [self addSubview:self.alertView];
    
    self.frame = view.bounds;
    self.contextView.frame = self.bounds;
    
    if (self.customView == nil) {
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.spliter];
        [self.alertView addSubview:self.contentLabel];
        [self.alertView addSubview:self.optsView];
        [self.alertView addSubview:self.activityView];
        
        if (!self.isAlertViewHiddenCancel) {
            if (CGRectEqualToRect(self.alertView.frame, CGRectZero)) {
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.options];
                if (self.options.count == 1 && !self.isAlertViewVertical) {
                    [array insertObject:self.cancelStr atIndex:0];
                } else {
                    [array addObject:self.cancelStr];
                }
                self.options = array;
            }
        }
        
        self.isAlertViewVisible = YES;
        CGSize topSize = [self titleLabelSize];
        self.top = topSize.height;
        self.middle = [self contentLabelSize].height;
        self.bottom = [self optsSize].height;
        
        [self.titleLabel setFrame:CGRectMake(self.titleInsets.left,
                                             self.titleInsets.top,
                                             self.optMaxWidth - self.titleInsets.left - self.titleInsets.right,
                                             self.top)];
        
        [self.spliter setFrame:CGRectMake(self.titleInsets.left,
                                          self.top == 0 ? 0 : self.top + self.titleInsets.top + self.titleInsets.bottom,
                                          self.optMaxWidth - self.titleInsets.left - self.titleInsets.right,
                                          self.top == 0 ? 0 : 0.5f)];
        
        [self.contentLabel setFrame:CGRectMake(self.contentInsets.left,
                                               CGRectGetMaxY(self.spliter.frame) + ((self.middle == 0.0f) ? 0 : self.contentInsets.top),
                                               self.optMaxWidth - self.contentInsets.left - self.contentInsets.right,
                                               self.middle)];
        
        [self.optsView setFrame:CGRectMake(0,
                                           CGRectGetMaxY(self.contentLabel.frame) + (self.middle == 0.0f ? 0 : self.contentInsets.bottom),
                                           self.optMaxWidth,
                                           self.bottom)];
        
        [self.activityView setFrame:CGRectMake((self.optMaxWidth - topSize.width) / 2 - 30,
                                               CGRectGetMinY(self.titleLabel.frame) - 3,
                                               25, 25)];
        
        // 总高度
        CGFloat h = ((self.top == 0.0f) ? 0 : self.top + self.titleInsets.top + self.titleInsets.bottom) +
        ((self.middle == 0.0f ? 0 : self.middle + self.contentInsets.top + self.contentInsets.bottom) +
         self.bottom);
        self.alertView.frame = CGRectMake((CGRectGetWidth(view.frame) - self.optMaxWidth) / 2,
                                          (CGRectGetHeight(view.frame) - h) / 2,
                                          self.optMaxWidth,
                                          h);
        
        CGFloat allHeight = 0;
        for (UIView *v in [self.optsView subviews]) {
            [v removeFromSuperview];
        }
        
        for (int idx = 0; idx < self.options.count; idx++) {
            NSString *obj = self.options[idx];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:idx];
            [btn setTitle:obj forState:0];
            btn.titleLabel.numberOfLines = 0;
            [btn addTarget:self action:@selector(btnCallback:) forControlEvents:UIControlEventTouchUpInside];
            [self.optsView addSubview:btn];
            
            if (!self.isAlertViewHiddenCancel && ((self.isAlertViewHorizontal && idx == 0) || (!self.isAlertViewHorizontal && idx == self.options.count - 1))) {
                [self setStyle:self.cancelAttributes alsoSender:btn];
            } else {
                [self setStyle:self.optAttributes alsoSender:btn];
            }
            
            if (!self.isAlertViewHorizontal) {
                CGFloat height = [obj ssav_stringSizeAttachFont:[self ssav_font] attachMaxSize:CGSizeMake(self.optMaxWidth, MAXFLOAT)].height + SSAlertViewOptMargin;
                if (height < self.optHeight) {
                    height = self.optHeight;
                }
                
                [btn setFrame:CGRectMake(0,
                                         allHeight + SSAlertViewOptDistance * (idx + 1),
                                         self.optMaxWidth,
                                         height)];
                allHeight += height;
                
            } else {
                CGFloat width = self.optMaxWidth / 2;
                [btn setFrame:CGRectMake((width + SSAlertViewOptDistance) * idx,
                                         0,
                                         width,
                                         self.optHeight)];
            }
        }
    } else {
        [self.alertView addSubview:self.customView];
        [self.alertView setFrame:CGRectMake((CGRectGetWidth(view.frame) - self.customSize.width) / 2,
                                            (CGRectGetHeight(view.frame) - self.customSize.height) / 2,
                                            self.customSize.width,
                                            self.customSize.height)];
        [self.customView setFrame:self.alertView.bounds];
    }
    
    [self showAnimation];
}

- (void)showAnimation {
    self.alertView.alpha = 0.5f;
    self.alertView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    self.contextView.alpha = 0.0f;
    [UIView animateWithDuration:0.15f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alertView.alpha = 1.0f;
                         self.alertView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         self.contextView.alpha = 0.4f;
                     }
                     completion:^(BOOL finished) {
                         self.alertView.layer.transform = CATransform3DIdentity;
                     }];
}

- (void)close {
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
                         self.alertView.alpha = 0.0f;
                         self.contextView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         self.isAlertViewVisible = NO;
                         self.alertView.transform = CGAffineTransformIdentity;
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

- (void)btnCallback:(UIButton *)sender {
    if (self.callback) {
        self.callback(sender.tag);
    }
    
    if (!self.isAlertViewAlwaysVisible) {
        [self close];
    }
}

- (void)setEnable:(BOOL)enable alsoIndex:(NSInteger)index {
    if (self.options.count > index) {
        for (UIButton *v in self.optsView.subviews) {
            if (v.tag == index) {
                [v setEnabled:enable];
            }
        }
    }
}

- (void)setStyle:(NSDictionary *)attributes alsoSender:(UIButton *)sender {
    UIFont *font = attributes[SSAlertViewOptFont];
    UIColor *nmlColor = attributes[SSAlertViewOptNormalBackgroundColor];
    UIColor *hltColor = attributes[SSAlertViewOptHighlightBackgroundColor];
    UIColor *disColor = attributes[SSAlertViewOptDisableTextBackgroundColor];
    UIColor *nmlTextColor = attributes[SSAlertViewOptNormalTextColor];
    UIColor *hltTextColor = attributes[SSAlertViewOptHighlightTextColor];
    UIColor *disTextColor = attributes[SSAlertViewOptDisableTextColor];
    
    if (nmlColor) {
        [sender setBackgroundImage:nmlColor.ssav_image forState:0];
    }
    if (hltColor) {
        [sender setBackgroundImage:hltColor.ssav_image forState:UIControlStateHighlighted];
    }
    if (nmlTextColor) {
        [sender setTitleColor:nmlTextColor forState:0];
    }
    if (hltTextColor) {
        [sender setTitleColor:hltTextColor forState:UIControlStateHighlighted];
    }
    if (disColor) {
        [sender setBackgroundImage:disColor.ssav_image forState:UIControlStateDisabled];
    }
    if (disTextColor) {
        [sender setTitleColor:disTextColor forState:UIControlStateDisabled];
    }
    if (font) {
        [sender.titleLabel setFont:font];
    }
}

- (CGSize)titleLabelSize {
    NSString *str = self.titleLabel.text;
    if (str && str.length > 0) {
        return [self.titleLabel sizeThatFits:CGSizeMake(self.optMaxWidth - self.titleInsets.left - self.titleInsets.right, MAXFLOAT)];
    }
    return CGSizeZero;
}

- (CGSize)contentLabelSize {
    NSString *str = self.contentLabel.text;
    if (str && str.length > 0) {
        return [self.contentLabel sizeThatFits:CGSizeMake(self.optMaxWidth - self.contentInsets.left - self.contentInsets.right, MAXFLOAT)];
    }
    return CGSizeZero;
}

- (CGSize)optsSize {
    if (self.options.count == 0) {
        return CGSizeZero;
    } else {
        if (self.options.count == 1) {
            return CGSizeMake(self.optMaxWidth, self.optHeight);
        } else if (self.options.count == 2) {
            if (self.isAlertViewVertical) {
                return [self verticalOptsSize];
            } else {
                CGSize opt1Size = [self.options[0] ssav_stringSizeAttachFont:[self ssav_font] attachMaxSize:CGSizeMake(self.optMaxWidth / 2, MAXFLOAT)];
                CGSize opt2Size = [self.options[1] ssav_stringSizeAttachFont:[self ssav_font] attachMaxSize:CGSizeMake(self.optMaxWidth / 2, MAXFLOAT)];
                if ((MAX(opt1Size.height, opt2Size.height) + SSAlertViewOptMargin > self.optHeight) ||
                    (MAX(opt1Size.width, opt2Size.width) + SSAlertViewOptMargin > self.optMaxWidth / 2)) {
                    if (!self.isAlertViewHiddenCancel) { // 换位
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.options];
                        [arr exchangeObjectAtIndex:0 withObjectAtIndex:1];
                        self.options = arr;
                    }
                    return [self verticalOptsSize];
                }
                
                self.isAlertViewHorizontal = YES;
                return CGSizeMake(self.optMaxWidth, self.optHeight);
            }
        } else {
            return [self verticalOptsSize];
        }
    }
}

- (CGSize)verticalOptsSize {
    CGFloat height = 0;
    for (NSString *str in self.options) {
        CGFloat h = [str ssav_stringSizeAttachFont:[self ssav_font] attachMaxSize:CGSizeMake(self.optMaxWidth, MAXFLOAT)].height + SSAlertViewOptMargin;
        if (h < self.optHeight) {
            h = self.optHeight;
        }
        height += h + SSAlertViewOptDistance;
    }
    return CGSizeMake(self.optMaxWidth, height);
}

- (CGSize)optSize:(CGSize)size {
    return size.height < self.optHeight ? CGSizeMake(size.width, self.optHeight) : size;
}

- (UIFont *)ssav_font {
    return self.optAttributes[SSAlertViewOptFont];
}

- (void)contextViewTapHandler {
    if (self.isAlertViewTapToClose) {
        [self close];
    }
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        [_alertView.layer setCornerRadius:6.0f];
        [_alertView setClipsToBounds:YES];
    }
    return _alertView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:SSAlertViewTitleFont];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [SSAlertViewConfig ssav_titleLabelTextColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:SSAlertViewContentFont];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [SSAlertViewConfig ssav_contentLabelTextColor];
    }
    return _contentLabel;
}

- (UIView *)spliter {
    if (!_spliter) {
        _spliter = [[UIView alloc] init];
        _spliter.backgroundColor = [SSAlertViewConfig ssav_spliterColor];
    }
    return _spliter;
}

- (UIView *)optsView {
    if (!_optsView) {
        _optsView = [[UIView alloc] init];
        _optsView.backgroundColor = [SSAlertViewConfig ssav_optionSpliterColor];
    }
    return _optsView;
}

- (UIView *)contextView {
    if (!_contextView) {
        _contextView = [[UIView alloc] init];
        _contextView.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contextViewTapHandler)];
        [_contextView addGestureRecognizer:ges];
        [_contextView setUserInteractionEnabled:YES];
    }
    return _contextView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
