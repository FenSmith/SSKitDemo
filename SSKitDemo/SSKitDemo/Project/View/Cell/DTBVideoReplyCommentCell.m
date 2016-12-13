//
//  DTBVideoReplyCommentCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBVideoReplyCommentCell.h"
#import "DTBVideoReplyModel.h"

@interface DTBVideoReplyCommentCell()
@property (nonatomic,strong) UIImageView *avatorView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *likesButton;
@property (nonatomic,strong) UILabel *commentsLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *floorLabel;

@end

@implementation DTBVideoReplyCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.contentView addSubview:self.avatorView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.likesButton];
    [self.contentView addSubview:self.commentsLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.floorLabel];
    
    [self.avatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatorView.mas_right).offset(10);
        make.centerY.equalTo(self.avatorView);
    }];
    
    [self.likesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentsLabel);
        make.top.equalTo(self.commentsLabel.mas_bottom).offset(5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floorLabel.mas_right).offset(5);
        make.centerY.equalTo(self.floorLabel);
    }];
    
    [self.contentView viewAddBottomSpliter];
    
    return self;
}

- (void)bindWithDataSource:(DTBVideoReplyModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [self.avatorView sd_setImageWithURL:[NSURL URLWithString:dataSource.user.avator] placeholderImage:nil];
    self.nameLabel.text = dataSource.user.name;
    self.commentsLabel.text = dataSource.comments;
    self.timeLabel.text = [[NSDate dateWithTimeIntervalSince1970:dataSource.createTime] dateStringWithFormat:@"MM-dd HH:mm"];
    
    [self.likesButton setTitle:[NSString stringWithFormat:@" %@",dataSource.likes] forState:0];
    self.likesButton.selected = dataSource.likes.integerValue > 0;
    
    self.floorLabel.text = [NSString stringWithFormat:@"%d楼",(int)indexPath.row + 1];
}

+ (CGFloat)cellHeightWithModel:(DTBVideoReplyModel *)model {
    CGFloat height = 0;
    height += 10 + 25 + 5; // 头像
    height += [model.comments stringSizeWithFont:14 maxSize:CGSizeMake(kScreenW - 50, MAXFLOAT)].height;
    height += 20;
    height += 5;
    return height;
}

- (UIImageView *)avatorView {
    if (!_avatorView) {
        _avatorView = [[UIImageView alloc] init];
        _avatorView.backgroundColor = UIColorFromRGBBytes(245.0, 245.0, 245.0f);
        [_avatorView viewAddCornerRadius:12.5f];
    }
    return _avatorView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelAddTextColor:UIColorFromRGBBytes(67, 144, 226) alsoFont:13];
    }
    return _nameLabel;
}

- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [UIButton buttonAddTitleColor:SSHelpColor alsoFont:13];
        [_likesButton setImage:[[UIImage imageNamed:@"icon-like-n"] imageScale:4.0f] forState:0];
        [_likesButton setImage:[[UIImage imageNamed:@"icon-like-y"] imageScale:4.0f] forState:1<<2];
    }
    return _likesButton;
}

- (UILabel *)commentsLabel {
    if (!_commentsLabel) {
        _commentsLabel = [UILabel labelAddTextColor:UIColorFromRGBBytes(37, 37, 37) alsoFont:14];
        _commentsLabel.numberOfLines = 0;
    }
    return _commentsLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelAddTextColor:SSHelpColor alsoFont:12];
    }
    return _timeLabel;
}

- (UILabel *)floorLabel {
    if (!_floorLabel) {
        _floorLabel = [UILabel labelAddTextColor:SSHelpColor alsoFont:12];
    }
    return _floorLabel;
}

@end
