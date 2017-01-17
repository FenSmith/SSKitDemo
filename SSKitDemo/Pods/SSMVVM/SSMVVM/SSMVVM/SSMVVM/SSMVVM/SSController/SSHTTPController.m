//
//  SSHTTPController.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/18.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSHTTPController.h"
#import "SSHTTPViewModel.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <AFNetworking/AFNetworking.h>
#import <SSStatus/UIView+StatusAdd.h>
#import <SSProgressIndicator/SSProgressIndicator.h>
#import <SSCategory/UIColor+SSKit.h>
#import <SSKitUtility/SSAppHandler.h>

@interface SSHTTPController ()<UIWebViewDelegate>
@property (nonatomic,strong) SSProgressIndicator *progressIndicator;

@property (nonatomic,strong) SSHTTPViewModel *viewModel;
@end

@implementation SSHTTPController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.progressIndicator];
    [self.progressIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_offset(3);
    }];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, HTTPUrl)
     subscribeNext:^(NSString *url) {
         @strongify(self);
         [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
     }];
    
    if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        @weakify(self);
        [self.view showStatusViewWithType:SSStatusViewTypeNetworkError alsoCallback:^{
            @strongify(self);
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.viewModel.HTTPUrl]]];
        } isDisplayCallback:^BOOL{
            if ([AFNetworkReachabilityManager sharedManager].isReachable) {
                return NO;
            }
            return YES;
        }];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!self.viewModel.title || self.viewModel.title.length == 0) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if (title.length > 20) {
            title = [title substringToIndex:20];
        }
        self.viewModel.title = title;
    }
    
    [self.progressIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressIndicator startAnimating];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [_webView scalesPageToFit];
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (SSProgressIndicator *)progressIndicator {
    if (!_progressIndicator) {
        _progressIndicator = [[SSProgressIndicator alloc] init];
        _progressIndicator.strokeColor = [SSAppHandler sharedHander].webProgressIndicatorColor;
    }
    return _progressIndicator;
}

@end
