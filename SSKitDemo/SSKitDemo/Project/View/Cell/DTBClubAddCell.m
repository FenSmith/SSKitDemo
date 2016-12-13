//
//  DTBClubAddCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/24.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubAddCell.h"

@interface DTBClubAddCell()
@property (nonatomic,strong) UIButton *imageView;

@end

@implementation DTBClubAddCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
//    self.contentView.backgroundColor = [[UIColor colorWithRGB:@"202,208,212"] colorWithAlphaComponent:0.6f];
    [self.contentView viewAddCornerRadius:3.0f alsoWidth:2.0f alsoColor:[UIColor colorWithRGB:@"240,240,240"]];
    
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    return self;
}

- (void)bindWithDataSource:(id)dataSource {
    if ([dataSource isKindOfClass:[NSString class]]) {
        [self.imageView setImage:[[UIImage imageNamed:@"icon-club-image-add"] imageScale:2.0f] forState:0];
    } else {
        [self.imageView setImage:dataSource forState:0];
    }
}

- (UIButton *)imageView {
    if (!_imageView) {
        _imageView = [[UIButton alloc] init];
        _imageView.userInteractionEnabled = NO;
    }
    return _imageView;
}

@end
