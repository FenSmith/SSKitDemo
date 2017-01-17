//
//  HZRegistViewModel.h
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSKit/SSKitHeader.h>

@interface DTBRegistViewModel : SSTableViewModel

@property (nonatomic,copy) NSString *phone;

@property (nonatomic,strong) RACCommand *userRegistCommand;
@property (nonatomic,strong) RACSignal *phoneValidSignal;

@end
