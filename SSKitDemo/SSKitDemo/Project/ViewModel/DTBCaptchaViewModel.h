//
//  HZCaptchaViewModel.h
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSMVVM/SSMVVM.h>

@interface DTBCaptchaViewModel : SSTableViewModel

@property (nonatomic,strong) RACCommand *userRegistCommand;
@property (nonatomic,strong) RACCommand *requestCaptchaCommand;

@property (nonatomic,copy) NSString *captcha;
@property (nonatomic,copy) NSString *phone;

- (RACSignal *)retryButtonTitleAndEnable;

@property (nonatomic,strong) RACSignal *registValidSignal;

@end
