//
//  UIView+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ SS_TapGesture_Block)();
typedef void (^ SS_PanGesture_Block)(UIGestureRecognizerState state);

@interface UIView (SSKit)

+ (UIView *)viewAddColor:(UIColor *)color;
+ (UIView *)viewAddHexColor:(NSString *)color;
+ (UIView *)viewAddColor:(UIColor *)color alsoAlpha:(CGFloat)alpha;

- (void)viewAddTapGestureWithHandler:(SS_TapGesture_Block)handler;
- (void)viewAddHandlerWithTarget:(id)target alsoSEL:(SEL)selector;
- (void)viewAddPanGestureWithHandler:(SS_PanGesture_Block)handler;

- (void)viewAddCornerRadius:(CGFloat)radius alsoWidth:(CGFloat)width alsoColor:(UIColor *)color;
- (void)viewAddCornerRadius:(CGFloat)radius;

- (void)removeAllSubviews;
- (void)removeAllSubviewsWithType:(Class)type;

- (UIView *)viewAddSpliterWithWidth:(CGFloat)lineWidth alsoColor:(UIColor *)color alsoPadding:(CGFloat)padding alsoIsTopPosition:(BOOL)isTop;
- (UIView *)viewAddSpliterWithWidth:(CGFloat)lineWidth alsoColor:(UIColor *)color alsoPadding:(CGFloat)padding alsoIsLeftPosition:(BOOL)isLeft;
- (UIView *)viewAddTopSpliter;
- (UIView *)viewAddBottomSpliter;
- (void)viewAddBothSpliter;

- (UIImageView *)viewAddBackgroundViewWithImage:(UIImage *)image alsoAlpha:(CGFloat)alpha;
- (UIView *)viewAddBackgroundViewWithColor:(UIColor *)color alsoAlpha:(CGFloat)alpha;

+ (UIView *)viewWhiteSpliter;
+ (UIView *)viewGraySpliter;

- (void)viewAddShadowColor:(UIColor *)color alsoOffset:(CGSize)offset alsoRadius:(CGFloat)radius alsoOpacity:(CGFloat)opacity;

@end
