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
#import <SSWrapper/UIView+StatusAdd.h>
#import <SSWrapper/SSWebProgressView.h>
#import <SSKitUtility/UIColor+SSKit.h>
#import <SSKitUtility/SSAppHandler.h>

@interface SSHTTPController ()<UIWebViewDelegate>
@property (nonatomic,strong) SSWebProgressView *progressView;

@property (nonatomic,strong) SSHTTPViewModel *viewModel;
@end

@implementation SSHTTPController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_offset(3);
    }];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, linkURL)
     subscribeNext:^(NSString *linkURL) {
         @strongify(self);
         [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:linkURL]]];
     }];
    
    if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        @weakify(self);
        [self.view viewAddStatusWithType:SSStatusViewTypeNetworkError forTouchCallback:^(SSStatusBaseView *baseView) {
            @strongify(self);
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.viewModel.linkURL]]];
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
    if (!_viewModel.title || _viewModel.title.length == 0) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if (title.length > 20) {
            title = [title substringToIndex:20];
        }
        _viewModel.title = title;
    }
    
    [_progressView webViewFinishLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressView webViewReadyToLoading];
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

- (SSWebProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[SSWebProgressView alloc] init];
        _progressView.fillColor = [SSAppHandler sharedHander].webProgressIndicatorColor;
    }
    return _progressView;
}

@end
