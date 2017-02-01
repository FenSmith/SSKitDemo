//
//  SSBarEntity.m
//  SSKit
//
//  Created by Quincy Yan on 16/5/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSBarEntity.h"

#import <SDWebImage/UIButton+WebCache.h>
#import <Masonry/Masonry.h>
#import <SSKitUtility/NSString+SSKit.h>
#import <SSKitUtility/SSAppHandler.h>

#define SSMVVMSTRINGLIZE(x) #x

@interface SSBarEntity()
@property (nonatomic,strong) UIView *badgeView;
@property (nonatomic,strong) NSMutableDictionary *imageKeys;

@end

@implementation SSBarEntity

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    [self addSubview:self.internalButton];
    [self.internalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.badgeView];
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
    [self setup];
    
    return self;
}

- (void)setup {
    _badgeView.hidden = YES;
    _imageKeys = [NSMutableDictionary dictionary];
}

+ (SSBarEntity *)setupEntityWithTitle:(NSString *)title {
    return [self setupEntityWithNormalImage:nil withTitle:title];
}

+ (SSBarEntity *)setupEntityWithNormalImage:(UIImage *)image {
    return [self setupEntityWithNormalImage:image withTitle:nil];
}

+ (SSBarEntity *)setupEntityWithNormalImage:(UIImage *)image withTitle:(NSString *)title {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    if (title) {
        [obj setTitle:title];
    }
    if (image) {
        [obj setImage:image forState:UIControlStateNormal];
    }
    return obj;
}

+ (SSBarEntity *)setupEntityWithNormalImage:(UIImage *)image withHighlightImage:(UIImage *)highlightImage {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    if (image) {
        [obj setImage:image forState:UIControlStateNormal];
    }
    if (highlightImage) {
        [obj setImage:highlightImage forState:UIControlStateHighlighted];
    }
    return obj;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [_internalButton setTitle:title forState:UIControlStateNormal];
}

- (void)setBadgeValue:(NSInteger)badgeValue {
    _badgeValue = badgeValue;
    _badgeView.hidden = badgeValue <= 0;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (!image) return;
    
    _imageSize = image.size;
    if ([image isKindOfClass:[UIImage class]]) {
        [_internalButton setImage:image forState:state];
    }
}

- (void)setImage:(NSString *)image withPlaceHolderImage:(UIImage *)placeHolderImage forState:(UIControlState)state {
    if (!image) return;
    if ([image isKindOfClass:[NSString class]]) {
        [_internalButton sd_setImageWithURL:[NSURL URLWithString:image] forState:state placeholderImage:placeHolderImage];
    }
}

- (CGSize)calculateSizeForEntity {
    if (!CGSizeEqualToSize(self.entitySize, CGSizeZero)) return self.entitySize;
    
    CGSize size = CGSizeZero;
    if (!CGSizeEqualToSize(self.imageSize, CGSizeZero)) {
        size = self.imageSize;
    }
    
    if (self.title && self.title.length > 0) {
        CGFloat width = [_title stringSizeWithFont:[self fontSizeForIntervalButton] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        size.width += width;
        
        if (size.height == 0) {
            size.height += 30;
        }
    }
    
    size.width += [SSAppHandler sharedHander].navigationbarItemsSpareSpace;
    size.height += 10;
    return size;
}

- (NSUInteger)fontSizeForIntervalButton {
    return _internalButton.titleLabel.font.pointSize;
}

- (UIButton *)internalButton {
    if (!_internalButton) {
        _internalButton = [[UIButton alloc] init];
        [_internalButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    return _internalButton;
}

- (UIView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[UIView alloc] init];
        _badgeView.backgroundColor = [UIColor redColor];
        _badgeView.layer.cornerRadius = 4.0f;
        _badgeView.clipsToBounds = YES;
    }
    return _badgeView;
}

@end
