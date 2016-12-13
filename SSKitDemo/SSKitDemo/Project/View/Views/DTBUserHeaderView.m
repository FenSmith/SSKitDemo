//
//  DTBUserHeaderView.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/10.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserHeaderView.h"

@interface DTBUserHeaderView()
@property (nonatomic,strong) UIImageView *avatorView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation DTBUserHeaderView

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if(!self) return nil;
    
    [self viewAddBackgroundViewWithImage:[UIImage imageContentName:@"icon-user-avator-bg"] alsoAlpha:1.0f];
    
    [self addSubview:self.avatorView];
    [self.avatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatorView.mas_right).offset(20);
        make.centerY.equalTo(self.avatorView);
    }];
    
    [self viewAddBottomSpliter];
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    [self reloadUserViews];
    
    [self viewAddTapGestureWithHandler:^{
        if ([DTBUserModel isUserLogin]) {
            [SSPageRouter openProtocol:@"sspage://DTBUserDetailViewModel"];
        } else {
            [SSPageRouter openProtocol:@"sspage://DTBLoginViewModel"];
        }
    }];
}

- (void)bindNotifications {
    [super bindNotifications];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:DTBUserLoginNotification object:nil]
     subscribeNext:^(id x) {
         @strongify(self);
         [self reloadUserViews];
     }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:DTBUserLogoutNotification object:nil]
     subscribeNext:^(id x) {
         @strongify(self);
         [self reloadUserViews];
     }];
}

- (void)reloadUserViews {
    DTBUserModel *user = [DTBUserModel user];
    NSString *plsImage = @"";
    switch (user.gender) {
        case DTBUserTypeUnknow: plsImage = @"icon-avator-boy";
            break;
        case DTBUserTypeMan: plsImage = @"icon-avator-boy";
            break;
        case DTBUserTypeFemale: plsImage = @"icon-avator-girl";
            break;
        default:
            break;
    }
    [self.avatorView sd_setImageWithURL:[NSURL URLWithString:user.avator] placeholderImage:[UIImage imageNamed:plsImage]];
    self.nameLabel.text = [DTBUserModel isUserLogin] ? user.name : @"未登录";
}

- (UIImageView *)avatorView {
    if (!_avatorView) {
        _avatorView = [[UIImageView alloc] init];
        [_avatorView viewAddCornerRadius:25.0f alsoWidth:0.5f alsoColor:SSSpliterColor];
    }
    return _avatorView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelAddTextColor:[UIColor whiteColor] alsoFont:15];
    }
    return _nameLabel;
}

@end
