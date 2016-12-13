//
//  SSTabbar.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTabbar.h"

@interface SSTabbar()
@property (nonatomic,strong) SSTabbarEntity *selectedEntity;

@end

@implementation SSTabbar

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.selectedIndex = 0;
    
    return self;
}

+ (SSTabbar *)registWithEntities:(NSArray *)entities setDelegate:(id)delegate {
    SSTabbar *obj = [[SSTabbar alloc] init];
    obj.delegate = delegate;
    obj.entities = entities;
    return obj;
}

- (void)reloadAllEntities {
    [self setupAllEntities];
    [self reloadAllEntitiesSize];
}

- (void)clearAllBadgeValues {
    for (SSTabbarEntity *entity in self.entities) {
        [entity resetBadgeValue:0];
    }
}

- (void)clearBadgeValueAtIndex:(NSUInteger)index {
    [self resetBadgeValue:0 atIndex:index];
}

- (void)resetBadgeValue:(NSInteger)badgeValue atIndex:(NSUInteger)index {
    if (index > self.entities.count - 1) return ;
    SSTabbarEntity *entity = [self.entities objectAtIndex:index];
    [entity resetBadgeValue:badgeValue];
}

- (void)setupAllEntities {
    for (int i = 0; i < self.entities.count; i ++) {
        SSTabbarEntity *entity = self.entities[i];
        [entity setTag:i];
        [entity addTarget:self action:@selector(entityDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [entity addTarget:self action:@selector(entityDidDoubleSelected:) forControlEvents:UIControlEventTouchDownRepeat];
        [self addSubview:entity];
        
        if (i == self.selectedIndex) {
            [self entityDidSelected:entity];
        }
    }
}

- (void)entityDidSelected:(SSTabbarEntity *)sender {
    if ([self.delegate respondsToSelector:@selector(tabbar:entitySelectedCallback:)]) {
        BOOL succ = [self.delegate tabbar:self entitySelectedCallback:sender.tag];
        if (succ) {
            if (self.selectedEntity != sender) {
                self.selectedEntity.selected = NO;
                self.selectedEntity = sender;
                sender.selected = YES;
            }
        }
    }
}

- (void)entityDidDoubleSelected:(SSTabbarEntity *)sender {
    if ([self.delegate respondsToSelector:@selector(tabbar:entityDoubleSelectedCallback:)]) {
        [self.delegate tabbar:self entityDoubleSelectedCallback:sender.tag];
    }
}

- (void)reloadAllEntitiesSize {
    CGFloat totalWidth = 0;
    
    for (SSTabbarEntity *entity in self.entities) {
        CGSize size = CGSizeMake(entity.entitySize.width != 0 ? entity.entitySize.width : [self generalWidth],
                                 entity.entitySize.height != 0 ? entity.entitySize.height : [self generalHeight]);
        [entity setFrame:CGRectMake(totalWidth, [self generalHeight] - size.height, size.width, size.height)];
        totalWidth += size.width;
    }
}

- (CGFloat)generalWidth {
    CGFloat customWidth = 0;
    NSUInteger number = 0;
    
    if (!self.entities || self.entities.count == 0) return 0;
    
    for (SSTabbarEntity *entity in self.entities) {
        if (entity.entitySize.width != 0.0f) {
            customWidth += entity.entitySize.width;
            number ++;
        }
    }
    
    return ([UIScreen mainScreen].bounds.size.width - customWidth) / (self.entities.count - number);
}

- (CGFloat)generalHeight {
    return 49.0f;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (SSTabbarEntity *entity in self.entities) {
            CGPoint tempoint = [entity convertPoint:point fromView:self];
            if (CGRectContainsPoint(entity.bounds, tempoint)) {
                view = entity;
            }
        }
    }
    return view;
}

@end
