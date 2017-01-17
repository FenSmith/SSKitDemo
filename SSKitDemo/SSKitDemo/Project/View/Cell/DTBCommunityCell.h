//
//  DTBCommunityCell.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/31.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSKit/SSKitHeader.h>

@class DTBCommunityModel;
@interface DTBCommunityCell : SSTableViewCell

@property (nonatomic,strong) UIView *holderView;

- (void)addUserViews;
- (void)addAttachViews;

+ (CGFloat)userViewsHeight;
+ (CGFloat)attachViewsHeight;
+ (CGFloat)paddingHeight;

+ (NSString *)cellIdentifierAttachDataSource:(DTBCommunityModel *)dataSource;

@end
