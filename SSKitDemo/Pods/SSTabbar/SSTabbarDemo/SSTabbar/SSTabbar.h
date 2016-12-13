//
//  SSTabbar.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTabbarEntity.h"

@class SSTabbar;
@protocol SSTabbarDelegate <NSObject>

- (BOOL)tabbar:(SSTabbar *)tabbar entitySelectedCallback:(NSInteger)index;

@optional;
- (BOOL)tabbar:(SSTabbar *)tabbar entityDoubleSelectedCallback:(NSInteger)index;

@end

@interface SSTabbar : UIView

@property (nonatomic,strong) NSArray *entities;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic,weak) id<SSTabbarDelegate> delegate;

- (void)reloadAllEntities;

- (void)clearAllBadgeValues;
- (void)clearBadgeValueAtIndex:(NSUInteger)index;
- (void)resetBadgeValue:(NSInteger)badgeValue atIndex:(NSUInteger)index;

+ (SSTabbar *)registWithEntities:(NSArray *)entities setDelegate:(id)delegate;

@end
