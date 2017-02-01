//
//  SSTabbar.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTabbar.h"

@interface SSTabbar()
@property (nonatomic,strong) SSTabbarWrapper *selectedWrapper;

@end

@implementation SSTabbar

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    _selectedIndex = 0;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    _selectedIndex = 0;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    _selectedIndex = 0;
    return self;
}

+ (SSTabbar *)registWithWrappers:(NSArray *)wrappers forDelegate:(id)delegate {
    SSTabbar *obj = [[SSTabbar alloc] init];
    obj.delegate = delegate;
    obj.wrappers = wrappers;
    return obj;
}

- (void)reloadAllWrappers {
    [self setupAllEntities];
    [self reloadAllEntitiesSize];
}

- (void)clearAllBadgeValues {
    for (SSTabbarWrapper *wrapper in _wrappers) {
        [wrapper resetWrapperBadgeValue:0];
    }
}

- (void)clearBadgeValueAtIndex:(NSUInteger)index {
    [self resetBadgeValue:0 atIndex:index];
}

- (void)resetBadgeValue:(NSInteger)badgeValue atIndex:(NSUInteger)index {
    if (index > _wrappers.count - 1) return ;
    SSTabbarWrapper *entity = [_wrappers objectAtIndex:index];
    [entity resetWrapperBadgeValue:badgeValue];
}

- (void)setupAllEntities {
    for (int i = 0; i < _wrappers.count; i ++) {
        SSTabbarWrapper *wrapper = _wrappers[i];
        [wrapper setTag:i];
        [wrapper addTarget:self action:@selector(wrapperDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [wrapper addTarget:self action:@selector(wrapperDidDoubleClicked:) forControlEvents:UIControlEventTouchDownRepeat];
        [self addSubview:wrapper];
        
        if (i == self.selectedIndex) {
            [self wrapperDidClicked:wrapper];
        }
    }
}

- (void)wrapperDidClicked:(SSTabbarWrapper *)sender {
    if ([self.delegate respondsToSelector:@selector(tabbar:wrapperClickedAtIndex:)]) {
        BOOL succ = [self.delegate tabbar:self wrapperClickedAtIndex:sender.tag];
        if (succ) {
            if (_selectedWrapper != sender) {
                _selectedWrapper.selected = NO;
                _selectedWrapper = sender;
                sender.selected = YES;
            }
        }
    }
}

- (void)wrapperDidDoubleClicked:(SSTabbarWrapper *)sender {
    if ([self.delegate respondsToSelector:@selector(tabbar:wrapperDoubleClickedAtIndex:)]) {
        [self.delegate tabbar:self wrapperDoubleClickedAtIndex:sender.tag];
    }
}

- (void)reloadAllEntitiesSize {
    CGFloat totalWidth = 0;
    
    for (SSTabbarWrapper *wrapper in _wrappers) {
        CGSize size = CGSizeMake(wrapper.wrapperSize.width != 0 ? wrapper.wrapperSize.width : [self generalWidth],
                                 wrapper.wrapperSize.height != 0 ? wrapper.wrapperSize.height : [self generalHeight]);
        [wrapper setFrame:CGRectMake(totalWidth, [self generalHeight] - size.height, size.width, size.height)];
        totalWidth += size.width;
    }
}

- (CGFloat)generalWidth {
    if (!_wrappers || _wrappers.count == 0) return 0;
    
    CGFloat customWidth = 0;
    NSUInteger number = 0;
    for (SSTabbarWrapper *wrapper in _wrappers) {
        if (wrapper.wrapperSize.width != 0.0f) {
            customWidth += wrapper.wrapperSize.width;
            number ++;
        }
    }
    
    return ([UIScreen mainScreen].bounds.size.width - customWidth) / (_wrappers.count - number);
}

- (CGFloat)generalHeight {
    return 49.0f;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (SSTabbarWrapper *wrapper in _wrappers) {
            CGPoint tempoint = [wrapper convertPoint:point fromView:self];
            if (CGRectContainsPoint(wrapper.bounds, tempoint)) {
                view = wrapper;
            }
        }
    }
    return view;
}

@end
