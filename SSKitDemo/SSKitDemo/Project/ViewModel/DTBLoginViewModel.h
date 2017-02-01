//
//  HZLoginViewModel.h
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/27.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSMVVM/SSMVVM.h>

@interface DTBLoginViewModel : SSTableViewModel

@property (nonatomic,strong) RACCommand *userLoginCommand;
@property (nonatomic,strong) RACCommand *userRegistCommand;
@property (nonatomic,strong) RACCommand *userPsdCommand;

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;

@property (nonatomic,strong) RACSignal *submitValidSignal;

@end
