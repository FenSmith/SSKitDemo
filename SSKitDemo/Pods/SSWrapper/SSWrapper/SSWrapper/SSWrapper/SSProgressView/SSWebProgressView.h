//
//  SSWebProgressView.h
//  SSWrapper
//
//  Created by Quincy Yan on 2017/1/30.
//  Copyright © 2017年 Quincy Yan. All rights reserved.
//

#import "SSProgressView.h"

/**
 用于WebView加载的进度条
 前一段加载速度快
 后一段逐渐变慢
 并且在加载完成前拥有一个最大加载进度
 */
@interface SSWebProgressView : SSProgressView

/**
 WebView开始加载
 */
- (void)webViewReadyToLoading;

/**
 WebView结束加载
 */
- (void)webViewFinishLoading;

@end
