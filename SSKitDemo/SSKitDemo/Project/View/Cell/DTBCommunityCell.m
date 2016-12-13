//
//  DTBCommunityCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/31.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBCommunityCell.h"
#import "DTBCommunityModel.h"

@interface DTBCommunityCell()
@property (nonatomic,strong) UIImageView *avatorView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *watchButton;
@property (nonatomic,strong) UIButton *replyButton;

@end

@implementation DTBCommunityCell

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 8)];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self addUserViews];
    [self addAttachViews];
    
    [self.contentView addSubview:self.holderView];
    [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.avatorView.mas_bottom).offset(8);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-12);
    }];
    
    return self;
}

- (void)bindWithDataSource:(DTBCommunityModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [self.avatorView sd_setImageWithURL:[NSURL URLWithString:dataSource.user.avator] placeholderImage:nil];
    self.nameLabel.text = dataSource.user.name;
    [self.watchButton setTitle:[NSString stringWithFormat:@" %@",dataSource.watchs] forState:0];
    [self.replyButton setTitle:[NSString stringWithFormat:@" %@",dataSource.replys] forState:0];
    self.timeLabel.text = [self stringAttachTime:dataSource.createTime];
}

+ (CGFloat)userViewsHeight {
    return 8+25+8;
}

+ (CGFloat)attachViewsHeight {
    return 12+13+8;
}

+ (CGFloat)paddingHeight {
    return 8;
}

- (NSString *)stringAttachTime:(NSTimeInterval)time {
    NSTimeInterval curr = [NSDate date].timeIntervalSince1970;
    NSTimeInterval gap = curr - time;
    if (gap < 0) {
        return @"时间错误";
    } else if (gap > 0 && gap < 60){
        return [NSString stringWithFormat:@"%d秒前",(int)gap];
    } else if (gap >= 60 && gap < 3600) {
        return [NSString stringWithFormat:@"%d分钟前",(int)gap/60];
    } else if (gap > 3600 && gap < 86400) {
        return [NSString stringWithFormat:@"%d小时前",(int)gap/3600];
    } else {
        return [[NSDate dateWithTimeIntervalSince1970:time] dateStringWithFormatType:SSDateFormatTypeYMD];
    }
}

+ (NSString *)cellIdentifierAttachDataSource:(DTBCommunityModel *)dataSource {
    if (dataSource.images.count == 0) {
        return @"DTBCommunityTextCell";
    } else if(dataSource.images.count < 3) {
        return @"DTBCommunityImageCell";
    } else {
        return @"DTBCommunityImagesCell";
    }
}

- (void)addUserViews {
    [self.contentView addSubview:self.avatorView];
    [self.contentView addSubview:self.nameLabel];
    
    [self.avatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(8);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatorView.mas_right).offset(8);
        make.centerY.equalTo(self.avatorView);
    }];
}

- (void)addAttachViews {
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.watchButton];
    [self.contentView addSubview:self.replyButton];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    [self.watchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.replyButton.mas_left).offset(-8);
        make.centerY.equalTo(self.replyButton);
    }];
}

- (UIImageView *)avatorView {
    if (!_avatorView) {
        _avatorView = [UIImageView avatorViewAttachCornerRadius:12.5f];
    }
    return _avatorView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelAddTextColor:UIColorFromRGBBytes(67, 144, 226) alsoFont:13];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelAddTextColor:[UIColor colorWithRGB:@"162,162,162"] alsoFont:13];
    }
    return _timeLabel;
}

- (UIButton *)watchButton {
    if (!_watchButton) {
        _watchButton = [UIButton buttonAddTitleColor:[UIColor colorWithRGB:@"162,162,162"] alsoFont:13];
        [_watchButton setImage:[[UIImage imageNamed:@"icon-community-watch"] imageScale:1.5f] forState:0];
    }
    return _watchButton;
}

- (UIButton *)replyButton {
    if (!_replyButton) {
        _replyButton = [UIButton buttonAddTitleColor:[UIColor colorWithRGB:@"162,162,162"] alsoFont:13];
        [_replyButton setImage:[[UIImage imageNamed:@"icon-community-comment"] imageScale:2.0f] forState:0];
    }
    return _replyButton;
}

- (UIView *)holderView {
    if (!_holderView) {
        _holderView = [[UIView alloc] init];
    }
    return _holderView;
}


@end
