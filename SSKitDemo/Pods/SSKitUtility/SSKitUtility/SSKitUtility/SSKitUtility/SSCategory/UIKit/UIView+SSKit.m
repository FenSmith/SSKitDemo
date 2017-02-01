//
//  UIView+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIView+SSKit.h"
#import "UIColor+SSKit.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@interface UIView()
@property (nonatomic,copy) SS_TapGesture_Block tapGestureBlock;
@property (nonatomic,copy) SS_PanGesture_Block panGestureBlock;

@end

@implementation UIView (SSKit)
static char SSKit_TapGesture_Key, SSKit_PanGesture_Key;

+ (UIView *)viewAddColor:(UIColor *)color {
    return [self viewAddColor:color alsoAlpha:1.0f];
}

+ (UIView *)viewAddHexColor:(NSString *)color {
    return [self viewAddColor:[UIColor colorWithHexString:color] alsoAlpha:1.0f];
}

+ (UIView *)viewAddColor:(UIColor *)color alsoAlpha:(CGFloat)alpha {
    UIView *view = [[UIView alloc] init];
    if (color == nil) return view;
    if (color == [UIColor clearColor]) return view;
    
    view.backgroundColor = [color colorWithAlphaComponent:alpha];
    return view;
}

- (void)viewAddTapGestureWithHandler:(SS_TapGesture_Block)handler {
    if (handler == nil) return;
    
    self.tapGestureBlock = handler;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SS_TapGesture_Handler)];
    [self addGestureRecognizer:tapGesture];
}

- (void)SS_TapGesture_Handler {
    if (self.tapGestureBlock) {
        self.tapGestureBlock();
    }
}

- (void)setTapGestureBlock:(SS_TapGesture_Block)tapGestureBlock {
    objc_setAssociatedObject(self, &SSKit_TapGesture_Key, tapGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SS_TapGesture_Block)tapGestureBlock {
    return objc_getAssociatedObject(self, &SSKit_TapGesture_Key);
}

- (void)viewAddHandlerWithTarget:(id)target alsoSEL:(SEL)selector {
    if (target == nil || selector == nil) return;
    
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGesture];
}

- (void)viewAddPanGestureWithHandler:(SS_PanGesture_Block)handler {
    if (handler == nil) return;
    
    self.panGestureBlock = handler;
    self.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(SS_PanGesture_Handler:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)setPanGestureBlock:(SS_PanGesture_Block)panGestureBlock {
    objc_setAssociatedObject(self, &SSKit_PanGesture_Key, panGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SS_PanGesture_Block)panGestureBlock {
    return objc_getAssociatedObject(self, &SSKit_PanGesture_Key);
}

- (void)SS_PanGesture_Handler:(UIPanGestureRecognizer *)gesture {
    if (self.panGestureBlock) {
        self.panGestureBlock(gesture.state);
    }
}

- (void)viewAddCornerRadius:(CGFloat)radius alsoWidth:(CGFloat)width alsoColor:(UIColor *)color {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}

- (void)viewAddCornerRadius:(CGFloat)radius {
    [self viewAddCornerRadius:radius alsoWidth:0.0f alsoColor:nil];
}

- (void)removeAllSubviews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)removeAllSubviewsWithType:(Class)type {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:type]) {
            [subView removeFromSuperview];
        }
    }
}

- (void)viewWithBackgroundImage:(UIImage *)backgroundImage alsoAlpha:(CGFloat)alpha {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [imageView setAlpha:alpha];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIView *)viewAddSpliterWithWidth:(CGFloat)lineWidth alsoColor:(UIColor *)color alsoPadding:(CGFloat)padding alsoIsTopPosition:(BOOL)isTop{
    UIView *spliter = [[UIView alloc] init];
    if (color) {
        [spliter setBackgroundColor:color];
    }
    [self addSubview:spliter];
    
    if (isTop){
        [spliter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(lineWidth);
            make.top.and.right.equalTo(self);
            make.left.equalTo(self).offset(padding);
        }];
    }else {
        [spliter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(lineWidth);
            make.right.and.bottom.equalTo(self);
            make.left.equalTo(self).offset(padding);
        }];
    }
    
    return spliter;
}

- (UIView *)viewAddSpliterWithWidth:(CGFloat)lineWidth alsoColor:(UIColor *)color alsoPadding:(CGFloat)padding alsoIsLeftPosition:(BOOL)isLeft {
    UIView *spliter = [[UIView alloc] init];
    if (color) {
        [spliter setBackgroundColor:color];
    }
    [self addSubview:spliter];
    
    if (isLeft){
        [spliter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(lineWidth);
            make.top.and.bottom.equalTo(self);
            make.left.equalTo(self).offset(padding);
        }];
    } else {
        [spliter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(lineWidth);
            make.top.and.bottom.equalTo(self);
            make.right.equalTo(self).offset(padding);
        }];
    }
    
    return spliter;
}

- (UIView *)viewAddBottomSpliter {
    return [self viewAddSpliterWithWidth:0.5f alsoColor:[UIColor colorWithHexString:@"d7d7d7"] alsoPadding:0 alsoIsTopPosition:NO];
}

- (UIView *)viewAddTopSpliter {
    return [self viewAddSpliterWithWidth:0.5f alsoColor:[UIColor colorWithHexString:@"d7d7d7"] alsoPadding:0 alsoIsTopPosition:YES];
}

- (void)viewAddBothSpliter {
    [self viewAddSpliterWithWidth:0.5f alsoColor:[UIColor colorWithHexString:@"d7d7d7"] alsoPadding:0 alsoIsTopPosition:NO];
    [self viewAddSpliterWithWidth:0.5f alsoColor:[UIColor colorWithHexString:@"d7d7d7"] alsoPadding:0 alsoIsTopPosition:YES];
}

- (UIView *)viewAddBackgroundViewWithColor:(UIColor *)color alsoAlpha:(CGFloat)alpha {
    UIView *view = [UIView viewAddColor:[color colorWithAlphaComponent:alpha]];
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    return view;
}

- (UIImageView *)viewAddBackgroundViewWithImage:(UIImage *)image alsoAlpha:(CGFloat)alpha{
    UIImageView *view = [[UIImageView alloc] init];
    view.alpha = alpha;
    view.image = image;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    return view;
}

+ (UIView *)viewWhiteSpliter {
    return [UIView viewAddColor:[UIColor whiteColor]];
}

+ (UIView *)viewGraySpliter {
    return [UIView viewAddColor:[UIColor colorWithHexString:@"d7d7d7"]];
}

- (void)viewAddShadowColor:(UIColor *)color alsoOffset:(CGSize)offset alsoRadius:(CGFloat)radius alsoOpacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

@end
