//
//  HZLoginViewModel.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/27.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBLoginViewModel.h"
#import "DTBUserModel+SSAdd.h"

@implementation DTBLoginViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    self.leftBarButtons = @[[SSBarEntity setupEntityWithNormalImage:[[UIImage imageNamed:@"icon-return-white"] imageScale:2.7f]]];
    self.userRegistCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [SSPageRouter openProtocol:@"sspr://DTBRegistViewModel"];
        return [RACSignal empty];
    }];
    
    self.submitValidSignal = [RACSignal combineLatest:@[RACObserve(self, username),
                                                        RACObserve(self, password)]
                                              reduce:^id(NSString *username,NSString *password){
                                                  return @(username.length > 0 && password.length > 0);
                                              }];
    
    @weakify(self);
    self.userLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [SSDialog showDialogForDetail:@"登录中"];
        @strongify(self);
        return [[[[DTBRequestManager sharedManager] requestUserLogin:self.username password:self.password]
                doNext:^(NSDictionary *params) {
                    [DTBUserModel insertUserData:params];
                    [SSDialog showDialogWithType:SSDialogTypeCorrect forDetail:@"登录成功"];
                    [SSPageRouter closePage];
                }] doError:^(NSError *error) {
                    [SSErrorHandler errorHandlerWithError:error showInView:nil];
                }];
    }];
}

- (RACSignal *)leftBarItemClickedCallback:(NSInteger)index {
    [SSPageRouter closePage];
    return [RACSignal empty];
}

@end
