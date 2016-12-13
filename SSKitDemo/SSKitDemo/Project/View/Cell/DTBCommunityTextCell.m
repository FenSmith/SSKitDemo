//
//  DTBCommunityTextCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/1.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBCommunityTextCell.h"
#import "DTBCommunityModel.h"

@interface DTBCommunityTextCell()
@property (nonatomic,strong) UILabel *headlineLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation DTBCommunityTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.holderView addSubview:self.headlineLabel];
    [self.headlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.holderView);
        make.left.equalTo(self.holderView).offset(15);
        make.right.equalTo(self.holderView).offset(-15);
    }];
    
    [self.holderView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headlineLabel);
        make.top.equalTo(self.headlineLabel.mas_bottom).offset(10);
    }];
    
    return self;
}

- (void)bindWithDataSource:(DTBCommunityModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [super bindWithDataSource:dataSource indexPath:indexPath];
    self.headlineLabel.text = dataSource.title;
    self.contentLabel.text = dataSource.content;
}

+ (CGFloat)cellHeightWithModel:(DTBCommunityModel *)model {
    CGFloat headHeight = [model.title stringSizeWithFont:18 maxSize:CGSizeMake(kScreenW - 30, MAXFLOAT)].height;
    CGFloat contentHeight = [model.content stringSizeWithFont:15 maxSize:CGSizeMake(kScreenW - 30, MAXFLOAT)].height;
    return [self userViewsHeight] + headHeight + contentHeight + 10 + [self attachViewsHeight] + [self paddingHeight];
}

- (UILabel *)headlineLabel {
    if (!_headlineLabel) {
        _headlineLabel = [UILabel labelAddHexColor:@"0C0C0C" alsoFont:18];
        _headlineLabel.numberOfLines = 0;
    }
    return _headlineLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelAddHexColor:@"6F6F6F" alsoFont:15];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
