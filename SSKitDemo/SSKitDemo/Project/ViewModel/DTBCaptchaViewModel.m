//
//  HZCaptchaViewModel.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBCaptchaViewModel.h"

@implementation DTBCaptchaViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    self.requestCaptchaCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[[[DTBRequestManager sharedManager] requestUserRegistCaptcha:input]
                doNext:^(NSDictionary *params) {
                    [SSDialog showDialogWithType:SSDialogTypeCorrect forDetail:@"验证码请求成功"];
                }] doError:^(NSError *error) {
                    [SSErrorHandler errorHandlerWithError:error showInView:nil];
                    [SSPageRouter closePage];
                }];
    }];
    
    self.registValidSignal = [RACObserve(self, captcha) map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    
    self.userRegistCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [SSPageRouter openProtocol:@"sspr://DTBPsdViewModel" fetchParams:@{@"phone":self.phone,
                                                                             @"captcha":self.captcha}];
        return [RACSignal empty];
    }];
}

- (RACSignal *)retryButtonTitleAndEnable {
    static const NSInteger n = 60;
    
    @weakify(self);
    RACSignal *timer = [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
                         map:^id(id value) {
                             return nil;
                         }]
                        startWith:nil];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (NSInteger i = n; i >= 0; i--) {
        [numbers addObject:[NSNumber numberWithInteger:i]];
    }
    
    return [[[numbers.rac_sequence.signal zipWith:timer]
               map:^id(RACTuple *tuple) {
                   NSNumber *number = tuple.first;
                   NSInteger count = number.integerValue;
                   
                   @strongify(self);
                   if (count == 60) {
                       [self.requestCaptchaCommand execute:self.phone];
                   }
                   
                   if (count == 0) {
                       return RACTuplePack(@"重试", [NSNumber numberWithBool:YES]);
                   } else {
                       NSString *title = [NSString stringWithFormat:@"重试(%lds)", (long)count];
                       return RACTuplePack(title, [NSNumber numberWithBool:NO]);
                   }
               }]
              takeUntil:[self rac_willDeallocSignal]];
}

- (NSString *)titleForViewModel {
    return @"验证码";
}

@end
