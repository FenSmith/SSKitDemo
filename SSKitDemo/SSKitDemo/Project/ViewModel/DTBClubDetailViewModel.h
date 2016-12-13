//
//  DTBClubDetailViewModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/24.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSKit/SSKit.h>
#import "DTBCommunityModel.h"

@interface DTBClubDetailViewModel : SSTableViewModel
@property (nonatomic,strong) DTBCommunityModel *object;

@end
