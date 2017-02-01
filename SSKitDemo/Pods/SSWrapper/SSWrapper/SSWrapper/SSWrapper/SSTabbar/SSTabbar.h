//
//  SSTabbar.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTabbarWrapper.h"

@protocol SSTabbarDelegate;

@interface SSTabbar : UIView

@property (nonatomic,strong) NSArray<SSTabbarWrapper *> *wrappers;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic,weak) id<SSTabbarDelegate> delegate;

+ (SSTabbar *)registWithWrappers:(NSArray *)wrappers forDelegate:(id)delegate;

/**
 设置完内部控件后，必须调用该方法重新载入
 */
- (void)reloadAllWrappers;

- (void)clearAllBadgeValues;
- (void)clearBadgeValueAtIndex:(NSUInteger)index;
- (void)resetBadgeValue:(NSInteger)badgeValue atIndex:(NSUInteger)index;

@end

@protocol SSTabbarDelegate <NSObject>

- (BOOL)tabbar:(SSTabbar *)aTabbar wrapperClickedAtIndex:(NSInteger)index;
- (BOOL)tabbar:(SSTabbar *)aTabbar wrapperDoubleClickedAtIndex:(NSInteger)index;

@end
