//
//  HZRegistViewModel.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBRegistViewModel.h"

@implementation DTBRegistViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    self.phoneValidSignal = [RACSignal combineLatest:@[RACObserve(self, phone)]
                                              reduce:^id(NSString *phone){
                                                  return @(phone.length == 11);
                                              }];
    
    @weakify(self);
    self.userRegistCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (!self.phone || self.phone.length != 11) {
            [SSDialog showDialogWithType:SSDialogTypeWrong details:@"请输入正确的手机号码"];
        } else {
            [SSPageRouter openProtocol:@"sspage://DTBCaptchaViewModel" viewModelParams:@{@"phone":self.phone}];
        }
        return [RACSignal empty];
    }];
}

- (NSString *)titleForViewModel {
    return @"注册";
}

@end
