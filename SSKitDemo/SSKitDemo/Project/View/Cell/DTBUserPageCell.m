//
//  DTBUserPageCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/10.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserPageCell.h"
#import "DTBUserPageModel.h"

@interface DTBUserPageCell()
@property (nonatomic,strong) UIButton *iconView;
@property (nonatomic,strong) UILabel *propertyLabel;
@property (nonatomic,strong) UILabel *badgeLabel;

@end

@implementation DTBUserPageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.selectedBackgroundView = [UIView viewAddColor:UIColorFromRGBBytes(245, 245, 245) alsoAlpha:1.0f];
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.propertyLabel];
    [self.contentView addSubview:self.badgeLabel];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    [self.propertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.propertyLabel.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView viewAddBottomSpliter];
    
    return self;
}

- (void)bindWithViewModel:(SSViewModel *)viewModel dataSource:(DTBUserPageModel *)dataSource indexPath:(NSIndexPath *)indexPath {
    [self.iconView setImage:dataSource.icon forState:0];
    [self.iconView setBackgroundImage:dataSource.iconColor.colorImage forState:0];
    
    self.propertyLabel.text = dataSource.property;
    
    @weakify(self);
    [[RACObserve(dataSource, badgeValue)
      takeUntil:[self rac_prepareForReuseSignal]]
     subscribeNext:^(NSString *badgeValue) {
         @strongify(self);
         self.badgeLabel.text = badgeValue;
         self.badgeLabel.hidden = badgeValue.intValue == 0;
    }];
}

- (UIButton *)iconView {
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        _iconView.userInteractionEnabled = NO;
        [_iconView viewAddCornerRadius:5.0f];
    }
    return _iconView;
}

- (UILabel *)propertyLabel {
    if (!_propertyLabel) {
        _propertyLabel = [UILabel labelAddTextColor:SSNormalColor alsoFont:15];
    }
    return _propertyLabel;
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [UILabel labelAddTextColor:[UIColor whiteColor] alsoFont:16];
        [_badgeLabel viewAddCornerRadius:10.0f];
        _badgeLabel.backgroundColor = DTBAppThemeColor;
    }
    return _badgeLabel;
}

@end
