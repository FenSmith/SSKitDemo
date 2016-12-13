//
//  DTBCommunityImageCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/1.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBCommunityImageCell.h"
#import "DTBCommunityModel.h"

static CGFloat const DTBCommunityImageSize = 120;

@interface DTBCommunityImageCell()
@property (nonatomic,strong) UILabel *headlineLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *firstImageView;

@end

@implementation DTBCommunityImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.holderView addSubview:self.firstImageView];
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.holderView).offset(-15);
        make.top.bottom.equalTo(self.holderView);
        make.width.mas_equalTo(DTBCommunityImageSize);
    }];
    
    [self.holderView addSubview:self.headlineLabel];
    [self.headlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.holderView);
        make.left.equalTo(self.holderView).offset(15);
        make.right.equalTo(self.firstImageView.mas_left).offset(-15);
    }];
    
    [self.holderView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headlineLabel);
        make.right.equalTo(self.firstImageView.mas_left).offset(-15);
        make.bottom.equalTo(self.holderView);
    }];
    
    return self;
}

- (void)bindWithDataSource:(DTBCommunityModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [super bindWithDataSource:dataSource indexPath:indexPath];
    self.headlineLabel.text = dataSource.title;
    self.contentLabel.text = dataSource.content;
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:dataSource.images.firstObject[@"url"]] placeholderImage:nil];
}

+ (CGFloat)cellHeightWithModel:(NSObject *)model {
    return [self userViewsHeight] + DTBCommunityImageSize + [self attachViewsHeight] + [self paddingHeight];
}

- (UILabel *)headlineLabel {
    if (!_headlineLabel) {
        _headlineLabel = [UILabel labelAddHexColor:@"0C0C0C" alsoFont:18];
        _headlineLabel.numberOfLines = 2;
    }
    return _headlineLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelAddHexColor:@"6F6F6F" alsoFont:15];
        _contentLabel.numberOfLines = 3;
    }
    return _contentLabel;
}

- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [UIImageView imageViewAddScaleToFillType];
    }
    return _firstImageView;
}

@end
