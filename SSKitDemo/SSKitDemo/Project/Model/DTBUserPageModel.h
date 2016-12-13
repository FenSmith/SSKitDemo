//
//  DTBUserPageModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/10.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTBUserPageModel : NSObject

@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,copy) NSString *property;
@property (nonatomic,strong) NSNumber *badgeValue;
@property (nonatomic,strong) UIColor *iconColor;

@end
