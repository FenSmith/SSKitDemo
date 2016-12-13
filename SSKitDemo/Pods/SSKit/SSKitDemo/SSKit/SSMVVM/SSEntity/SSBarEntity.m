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
#import <SSCategory/NSString+SSKit.h>
#import <SSHandler/SSAppHandler.h>

static CGFloat const SSBarEntityPadding = 0;
static CGFloat const SSBarEntityBadgePadding = 0;

@interface SSBarEntity()
@property (nonatomic,strong) UIView *badgeView;

@end

@implementation SSBarEntity

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    [self addSubview:self.entityButton];
    [self.entityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.badgeView];
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-SSBarEntityBadgePadding);
        make.top.equalTo(self).offset(SSBarEntityBadgePadding);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
    [self.badgeView setHidden:YES];
    
    return self;
}

+ (SSBarEntity *)entityContainsImage:(UIImage *)image {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.image = image;
    return obj;
}

+ (SSBarEntity *)entityContainsImage:(NSString *)image alsoScale:(CGFloat)scale {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.image = [UIImage imageWithCGImage:[UIImage imageNamed:image].CGImage scale:scale orientation:UIImageOrientationUp];
    return obj;
}

+ (SSBarEntity *)entityContainsTitle:(NSString *)title {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.title = title;
    return obj;
}

+ (SSBarEntity *)entityContainsImage:(UIImage *)image alsoTitle:(NSString *)title {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.image = image;
    obj.title = title;
    return obj;
}

+ (SSBarEntity *)entityContainsImage:(UIImage *)image highlightImage:(UIImage *)helImage {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.image = image;
    obj.helImage = helImage;
    return obj;
}

+ (SSBarEntity *)entityContainsImage:(NSString *)image highlightImage:(NSString *)helImage alsoScale:(CGFloat)scale {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.image = [UIImage imageWithCGImage:[UIImage imageNamed:image].CGImage scale:scale orientation:UIImageOrientationUp];
    obj.helImage = [UIImage imageWithCGImage:[UIImage imageNamed:helImage].CGImage scale:scale orientation:UIImageOrientationUp];
    return obj;
}

+ (SSBarEntity *)entityContainsImage:(UIImage *)image highlightImage:(UIImage *)helImage alsoTitle:(NSString *)title {
    SSBarEntity *obj = [[SSBarEntity alloc] init];
    obj.image = image;
    obj.helImage = helImage;
    obj.title = title;
    return obj;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.entityButton setTitle:title forState:0];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.entityButton setImage:image forState:0];
}

- (void)setHelImage:(UIImage *)helImage {
    _helImage = helImage;
    [self.entityButton setImage:helImage forState:1<<0];
}

- (CGSize)sizeForEntity {
    CGSize size = CGSizeZero;
    
    if (!CGSizeEqualToSize(self.buttonSize, CGSizeZero)) {
        return self.buttonSize;
    }
    
    if (!CGSizeEqualToSize(self.imageSize, CGSizeZero)) {
        size = self.imageSize;
    } else if (self.image) {
        size = self.image.size;
    }
    
    if (self.title && self.title.length > 0) {
        if (!CGSizeEqualToSize(size, CGSizeZero)) {
            size.width += SSBarEntityPadding;
            self.entityButton.titleEdgeInsets = UIEdgeInsetsMake(0, SSBarEntityPadding, 0, 0);
        }
        
        CGSize titleSize = [self strSizeWithFont:self.entityButton.titleLabel.font.pointSize alsoMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) alsoStr:self.title];
        size.width += titleSize.width;
        
        if (size.height == 0) {
            size.height += 30;
        }
    }
    
    size.width += 2 * SSBarEntityPadding;
    size.width += [SSAppHandler sharedHander].navigationbarItemsSpareSpace;
    size.height += 10;
    return size;
}

- (CGSize)strSizeWithFont:(CGFloat)font alsoMaxSize:(CGSize)maxSize alsoStr:(NSString *)str {
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    return [str boundingRectWithSize:maxSize
                             options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                          attributes:attribute
                             context:nil].size;
}

- (void)setBadgeValue:(NSInteger)badgeValue {
    _badgeValue = badgeValue;
    [self.badgeView setHidden:badgeValue <= 0];
}

- (void)resetNetworkImage:(NSString *)image alsoPlaceHolderImage:(UIImage *)placeHolder {
    [self.entityButton sd_setImageWithURL:[NSURL URLWithString:image] forState:0 placeholderImage:placeHolder];
}

- (UIButton *)entityButton {
    if (!_entityButton) {
        _entityButton = [[UIButton alloc] init];
        [_entityButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    return _entityButton;
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
