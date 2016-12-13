//
//  SSViewController.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSViewController.h"
#import "SSBarEntity.h"
#import "SSViewModel.h"

#import <SSCategory/UIColor+SSKit.h>
#import <SSConfigure/SSEnums.h>
#import <SSConfigure/SSColors.h>
#import <SSHandler/SSAppHandler.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface SSViewController ()
@property (nonatomic,strong) SSViewModel *viewModel;
@end

@implementation SSViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SSViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindInitialization];
         [viewController bindNotification];
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    self.viewModel = viewModel;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = [SSAppHandler sharedHander].navigationTextAttributes;
    [self.navigationController.navigationBar setBackgroundImage:[SSAppHandler sharedHander].navigationBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[SSAppHandler sharedHander].navigationbarShadowImage];
}

- (void)clearNavigationBar {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)resetNavibarColor:(UIColor *)color {
    if (color) {
        [self.navigationController.navigationBar setBackgroundImage:color.colorImage forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)resetTitleColor:(UIColor *)color {
    if (color) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : color,
                                                                        NSFontAttributeName : [UIFont systemFontOfSize:17]};
    }
}

- (void)resetShadowSpliter {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)bindViewModel{
    @weakify(self);
    [RACObserve(self.viewModel, leftBarButtons)
     subscribeNext:^(NSArray *barButtons) {
         @strongify(self);
         self.navigationItem.leftBarButtonItems = [self barButtonsWithEntitys:barButtons isLeftEntitys:YES];
     }];
    
    [RACObserve(self.viewModel, rightBarButtons)
     subscribeNext:^(NSArray *barButtons) {
         @strongify(self);
         self.navigationItem.rightBarButtonItems = [self barButtonsWithEntitys:barButtons isLeftEntitys:NO];
     }];
    
    [[RACObserve(self.viewModel, title)
      filter:^BOOL(NSString *title) {
          return title && title.length > 0;
      }] subscribeNext:^(NSString *title) {
          @strongify(self);
          switch (self.viewModel.titleType) {
              case SSPageTitleTypeCenter: {
                  self.navigationItem.title = title;
              }
                  break;
              case SSPageTitleTypeLeft: {
                  self.viewModel.leftBarButtons = @[[SSBarEntity entityContainsImage:[SSAppHandler sharedHander].navigationbarImage alsoTitle:[NSString stringWithFormat:@" %@",title]]];
              }
                  break;
              case SSPageTitleTypeLeftOnlyTitle: {
                  self.viewModel.leftBarButtons = @[[SSBarEntity entityContainsTitle:title]];
              }
                  break;
              default:
                  break;
          }
      }];
}

- (void)bindNotification {
    
}

- (void)bindInitialization {
    
}

- (NSArray *)barButtonsWithEntitys:(NSArray *)entitys isLeftEntitys:(BOOL)isLeftEntitys {
    NSMutableArray *barButtons = [NSMutableArray array];
    for (int i = 0; i < entitys.count; i++) {
        id object = entitys[i];
        if ([object isKindOfClass:[SSBarEntity class]]) {
            SSBarEntity *entity = (SSBarEntity *)object;
            [entity setTag:i];
            
            if (isLeftEntitys) {
                [entity.entityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            } else {
                [entity.entityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            }
            
            CGSize size = [entity sizeForEntity];
            [entity setFrame:CGRectMake(0, 0, size.width, size.height)];
            [barButtons addObject:[[UIBarButtonItem alloc] initWithCustomView:entity]];
            
            @weakify(self);
            [[entity.entityButton rac_signalForControlEvents:UIControlEventTouchUpInside]
             subscribeNext:^(id x) {
                 @strongify(self);
                 NSNumber *entityTag = [NSNumber numberWithInteger:entity.tag];
                 if (isLeftEntitys) {
                     if (![self.viewModel hidesReturnButton] && entityTag.intValue == 0) {
                         [self.viewModel.backBarCommand execute:nil];
                     }else {
                         [self.viewModel.leftBarCommand execute:entityTag];
                     }
                 }else {
                     [self.viewModel.rightBarCommand execute:entityTag];
                 }
             }];
        }
    }
    return barButtons;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc{
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
