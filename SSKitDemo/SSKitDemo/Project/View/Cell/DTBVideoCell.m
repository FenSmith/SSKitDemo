//
//  DTBVideoCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBVideoCell.h"
#import "DTBVideoModel.h"

@interface DTBVideoCell()
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel, *timeLabel;
@property (nonatomic,strong) UIView *centerSpliter;
@property (nonatomic,strong) UIButton *commentButton, *likeButton;

@end

@implementation DTBVideoCell

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 10)];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.centerSpliter];
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.likeButton];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(15);
        make.top.equalTo(self.iconView);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.iconView.mas_bottom);
    }];
    
    [self.centerSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(15);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(0.5f);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView);
        make.top.equalTo(self.centerSpliter.mas_bottom).offset(10);
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentButton.mas_right).offset(15);
        make.top.equalTo(self.centerSpliter.mas_bottom).offset(10);
    }];
    
    [self.contentView viewAddBottomSpliter];
    
    return self;
}

- (void)bindWithDataSource:(DTBVideoModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:dataSource.cover] placeholderImage:nil];
    self.titleLabel.text = dataSource.title;
    self.timeLabel.text = [self fetchTimeFromTime:dataSource.createTime];
    [self.commentButton setTitle:[NSString stringWithFormat:@" %@",dataSource.comments] forState:0];
    [self.likeButton setTitle:[NSString stringWithFormat:@" %@",dataSource.likes] forState:0];
}

- (NSString *)fetchTimeFromTime:(NSInteger)createTime {
    NSTimeInterval now = [NSDate date].timeIntervalSince1970;
    NSTimeInterval gap = now - createTime;
    NSInteger minutes = gap / 60;
    NSInteger hours = gap / 3600;
    NSInteger days = gap / 86400;
    
    if (hours == 0 && days == 0) {
        return [NSString stringWithFormat:@"%d分钟前",(int)minutes];
    } else if (hours != 0 && days == 0) {
        return [NSString stringWithFormat:@"%d小时前",(int)hours];
    } else {
        return [[NSDate dateWithTimeIntervalSince1970:createTime] dateStringWithFormatType:SSDateFormatTypeYMD];
    }
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [_iconView viewAddCornerRadius:3.0f];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelAddTextColor:[UIColor colorWithHexString:@"646464"] alsoFont:13];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelAddTextColor:[UIColor colorWithHexString:@"aaaaaa"] alsoFont:13];
    }
    return _timeLabel;
}

- (UIView *)centerSpliter {
    if (!_centerSpliter) {
        _centerSpliter = [UIView viewAddColor:SSSpliterColor];
    }
    return _centerSpliter;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonAddTitleColorHex:@"8a8a8a" alsoFont:13];
        [_commentButton setImage:[[UIImage imageNamed:@"icon-video-comment"] imageScale:3.0f] forState:0];
    }
    return _commentButton;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [UIButton buttonAddTitleColorHex:@"8a8a8a" alsoFont:13];
        [_likeButton setImage:[[UIImage imageNamed:@"icon-video-like"] imageScale:3.0f] forState:0];
    }
    return _likeButton;
}

@end
