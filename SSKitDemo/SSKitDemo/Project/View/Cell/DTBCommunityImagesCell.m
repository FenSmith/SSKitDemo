//
//  DTBCommunityImagesCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/1.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBCommunityImagesCell.h"
#import "DTBCommunityModel.h"

static CGFloat const DTBCommunityImagePadding = 15;

@interface DTBCommunityImagesCell()
@property (nonatomic,strong) UILabel *headlineLabel;
@property (nonatomic,strong) UIImageView *firstImageView;
@property (nonatomic,strong) UIImageView *secondImageView;
@property (nonatomic,strong) UIImageView *thirdImageView;

@end

@implementation DTBCommunityImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.holderView addSubview:self.headlineLabel];
    [self.headlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.holderView);
        make.left.equalTo(self.holderView).offset(DTBCommunityImagePadding);
        make.right.equalTo(self.holderView).offset(-DTBCommunityImagePadding);
    }];
    
    [self.holderView addSubview:self.firstImageView];
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headlineLabel.mas_bottom).offset(10);
        make.left.equalTo(self.holderView).offset(DTBCommunityImagePadding);
        make.size.mas_equalTo(CGSizeMake([self imageItemSize], [self imageItemSize]));
    }];
    
    [self.holderView addSubview:self.secondImageView];
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImageView);
        make.left.equalTo(self.firstImageView.mas_right).offset(DTBCommunityImagePadding);
        make.size.mas_equalTo(CGSizeMake([self imageItemSize], [self imageItemSize]));
    }];
    
    [self.holderView addSubview:self.thirdImageView];
    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImageView);
        make.left.equalTo(self.secondImageView.mas_right).offset(DTBCommunityImagePadding);
        make.size.mas_equalTo(CGSizeMake([self imageItemSize], [self imageItemSize]));
    }];
    
    return self;
}

- (void)bindWithDataSource:(DTBCommunityModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [super bindWithDataSource:dataSource indexPath:indexPath];
    
    self.headlineLabel.text = dataSource.title;
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:dataSource.images.firstObject[@"url"]] placeholderImage:nil];
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:dataSource.images[1][@"url"]] placeholderImage:nil];
    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:dataSource.images.lastObject[@"url"]] placeholderImage:nil];
}

+ (CGFloat)cellHeightWithModel:(DTBCommunityModel *)model {
    CGFloat headHeight = [model.title stringSizeWithFont:18 maxSize:CGSizeMake(kScreenW - 2 * DTBCommunityImagePadding, MAXFLOAT)].height;
    CGFloat imageHeight = (kScreenW - 4 * DTBCommunityImagePadding) / 3;
    return [self userViewsHeight] + headHeight + 10 + imageHeight + [self attachViewsHeight] + [self paddingHeight];
}

- (CGFloat)imageItemSize {
    return (kScreenW - 4 * DTBCommunityImagePadding) / 3;
}

- (UILabel *)headlineLabel {
    if (!_headlineLabel) {
        _headlineLabel = [UILabel labelAddHexColor:@"0C0C0C" alsoFont:18];
        _headlineLabel.numberOfLines = 2;
    }
    return _headlineLabel;
}

- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [UIImageView imageViewAddScaleToFillType];
    }
    return _firstImageView;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [UIImageView imageViewAddScaleToFillType];
    }
    return _secondImageView;
}

- (UIImageView *)thirdImageView {
    if (!_thirdImageView) {
        _thirdImageView = [UIImageView imageViewAddScaleToFillType];
    }
    return _thirdImageView;
}

@end
