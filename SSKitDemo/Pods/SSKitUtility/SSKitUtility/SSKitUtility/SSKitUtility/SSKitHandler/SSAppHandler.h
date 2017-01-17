//
//  SSAppHandler.h
//  SSKit
//
//  Created by Quincy Yan on 16/1/1.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSEnums.h"

@protocol SSAppHandlerDelegate <NSObject>

@required
- (NSString *)ssah_server;

@optional
- (NSDictionary *)ssah_HTTPHeaderFields;
- (NSDictionary *)ssah_encryptParams:(NSDictionary *)params;
- (id)ssah_handleServerCallback:(id)callback error:(NSError *)error params:(NSDictionary *)params requestURL:(NSURL *)requestURL;
- (UIImage *)ssah_navigationBackgroundImage;
- (NSDictionary *)ssah_navigationTextAttributes;
- (UIImage *)ssah_navigationbarShadowImage;
- (UIImage *)ssah_navigationbarImage;
- (UIImage *)ssah_navigationbarHighlightImage;
- (CGFloat)ssah_navigationbarItemsSpareSpace;
- (SSPageTitleType)ssah_navigationTitleType;
- (UIColor *)ssah_webProgressIndicatorColor;
@end

@interface SSAppHandler : NSObject

+ (SSAppHandler *)sharedHander;
@property (nonatomic,weak) id<SSAppHandlerDelegate> delegate;

@property (nonatomic,strong) NSDictionary *ssah_HTTPHeaderFields;
- (NSDictionary *)ssah_encryptParams:(NSDictionary *)params;
- (id)ssah_filterCallback:(id)callback error:(NSError *)error params:(NSDictionary *)params requestURL:(NSURL *)requestURL;

@property (nonatomic,copy) NSString *server;
@property (nonatomic,strong) UIImage *navigationBackgroundImage;
@property (nonatomic,strong) NSDictionary *navigationTextAttributes;
@property (nonatomic,strong) UIImage *navigationbarImage;
@property (nonatomic,strong) UIImage *navigationbarHighlightImage;
@property (nonatomic,strong) UIImage *navigationbarShadowImage;
@property (nonatomic) SSPageTitleType navigationTitleType;
@property (nonatomic) CGFloat navigationbarItemsSpareSpace;
@property (nonatomic,strong) UIColor *webProgressIndicatorColor;

@end
