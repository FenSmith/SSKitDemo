//
//  DTBClubViewModel.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/9.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubViewModel.h"
#import "DTBCommunityModel.h"

@implementation DTBClubViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    self.isAllowLoadData = YES;
    self.isAllowLoadAdditionalData = YES;
    
    self.rightBarButtons = @[[SSBarEntity setupEntityWithNormalImage:[[UIImage imageNamed:@"icon-club-add"] imageScale:2.8f]]];
    
    self.didSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        [SSPageRouter openProtocol:@"sspr://DTBClubDetailViewModel" fetchParams:@{@"object":self.dataSource[indexPath.row]}];
        return [RACSignal empty];
    }];
}

- (NSArray *)content {
    return @[@{@"content":@"29岁的Susanna 和丈夫Andrew至今已在一起9年，本来他们会一直岁月静好地生活下去。但有一天，丈夫突然告诉Susanna：他想成为一个女人。丈夫以前就和自己说过，当他还是个孩子时，就想当女人。妻子同意了，在丈夫停精前他们通过试管婴儿，生下了一个儿子。",
               @"title":@"相恋结婚9年后 丈夫变妻子",
               @"createTime":@"1477989921",
               @"images":@[@{@"url":@"http://ww2.sinaimg.cn/mw690/85bdc80bjw1f9cnkq93xsj20ep08egne.jpg"},
                           @{@"url":@"http://ww4.sinaimg.cn/mw690/85bdc80bjw1f9cnkqlmdvj20f1074jsg.jpg"},
                           @{@"url":@"http://ww3.sinaimg.cn/mw690/85bdc80bjw1f9cnkr3fr7j20fe0h2q47.jpg"}],
               @"replys":@"0",
               @"watchs":@"0",
               @"user":@{@"name":@"155****0383",
                         @"avator":@"http://cdn.duitang.com/uploads/item/201508/12/20150812204022_xR2uQ.thumb.224_0.jpeg"}
               },
             @{@"content":@"董明珠：如何能做到不犯错误？在我看来，只要无私，就不会犯错误。",
               @"title":@"董明珠：我从来不犯错 该偏执时候要偏执",
               @"createTime":@"1477984423",
               @"images":@[],
               @"replys":@"0",
               @"watchs":@"441",
               @"user":@{@"name":@"等会我",
                         @"avator":@"http://tupian.qqjay.com/tou3/2016/0803/87a8b262a5edeff0e11f5f0ba24fb22f.jpg"}
               },
             @{@"content":@"“十一”黄金周期间市场关注度最高的事件就是一系列地产调控政策的出台。据不完全统计，有超过20个城市在“十一”黄金周前后出台了相关的房地产行业调控政策，具体内容包括限购、限贷等等。本轮地产价格上涨的逻辑何在？",
               @"title":@"地产",
               @"createTime":@"1477971280",
               @"images":@[],
               @"replys":@"0",
               @"watchs":@"1",
               @"user":@{@"name":@"等会我",
                         @"avator":@"http://tupian.qqjay.com/tou3/2016/0803/87a8b262a5edeff0e11f5f0ba24fb22f.jpg"}
               },
             @{@"content":@"美国白宫对FBI在大选投票前宣布重启对希拉里“邮件门”的调查做出谨慎回应，称对联邦调查局局长James Comey的决定“既不辩护，也不予批评”。10月28日，科米向美国国会致函，称收到了有关希拉里在担任国务卿期间使用私人电子邮箱处理公务的新信息，宣布FBI将调查新信息是否涉及国家秘密。",
               @"title":@"白宫回应FBI重启希拉里“邮件门”调查：不辩护，不批评",
               @"createTime":@"1477971222",
               @"images":@[@{@"url":@"http://ww2.sinaimg.cn/mw690/470bf257gw1f9cg8nuqynj21jk0rs7cj.jpg"}],
               @"replys":@"0",
               @"watchs":@"23",
               @"user":@{@"name":@"155****0383",
                         @"avator":@"http://cdn.duitang.com/uploads/item/201508/12/20150812204022_xR2uQ.thumb.224_0.jpeg"}
               }];
}

- (RACSignal *)rightBarItemClickedCallback:(NSInteger)index {
    [SSPageRouter presentProtocol:@"sspr://DTBClubAddViewModel"];
    return [RACSignal empty];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    @weakify(self);
    return [[[[[DTBRequestManager sharedManager] requestCommunityCommentsAttachPage:page]
              map:^id(NSArray *dataSource) {
                  return [NSArray yy_modelArrayWithClass:[DTBCommunityModel class] json:dataSource];
              }] doNext:^(id x) {
                  @strongify(self);
                  [self dataSourceHandler:x];
              }] doError:^(NSError *error) {
//                  [SSErrorHandler errorHandlerWithError:error showInView:nil];
                  @strongify(self);
                  NSArray *array = [NSArray yy_modelArrayWithClass:[DTBCommunityModel class] json:[self content]];
                  [self dataSourceHandler:array];
              }];
}

- (NSString *)titleForViewModel {
    return @"灌水社区";
}

- (SSPageTitleType)titleType {
    return SSPageTitleTypeLeftOnlyTitle;
}

- (BOOL)hidesReturnButton {
    return YES;
}

@end
