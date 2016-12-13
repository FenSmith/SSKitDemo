//
//  SSRequestService.h
//  SSKit
//
//  Created by Quincy Yan on 16/5/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>
#import <SSHandler/SSAppHandler.h>

typedef NS_ENUM(NSInteger , SSErrorDomain) {
    SSErrorDomainUnknow = -4000,
    SSErrorDomainEmptyData = -4001,
};

/**
 Apple Error Domain
 https://developer.apple.com/reference/foundation/1508628-url_loading_system_error_codes?language=objc
 
 NSURLErrorUnknown = -1
 NSURLErrorCancelled = -999
 NSURLErrorBadURL = -1000 
 NSURLErrorTimedOut = -1001
 NSURLErrorUnsupportedURL = -1002
 NSURLErrorCannotFindHost = -1003
 NSURLErrorCannotConnectToHost = -1004
 NSURLErrorDataLengthExceedsMaximum = -1103
 NSURLErrorNetworkConnectionLost = -1005
 NSURLErrorDNSLookupFailed = -1006
 NSURLErrorHTTPTooManyRedirects = -1007
 NSURLErrorResourceUnavailable = -1008
 NSURLErrorNotConnectedToInternet = -1009
 NSURLErrorRedirectToNonExistentLocation = -1010
 NSURLErrorBadServerResponse = -1011
 NSURLErrorUserCancelledAuthentication = -1012
 NSURLErrorUserAuthenticationRequired = -1013
 NSURLErrorZeroByteResource = -1014
 NSURLErrorCannotDecodeRawData = -1015
 NSURLErrorCannotDecodeContentData = -1016
 NSURLErrorCannotParseResponse = -1017
 NSURLErrorInternationalRoamingOff = -1018
 NSURLErrorCallIsActive = -1019
 NSURLErrorDataNotAllowed = -1020
 NSURLErrorRequestBodyStreamExhausted = -1021
 NSURLErrorFileDoesNotExist = -1100
 NSURLErrorFileIsDirectory = -1101
 NSURLErrorNoPermissionsToReadFile = -1102
 NSURLErrorSecureConnectionFailed = -1200
 NSURLErrorServerCertificateHasBadDate = -1201
 NSURLErrorServerCertificateUntrusted = -1202
 NSURLErrorServerCertificateHasUnknownRoot = -1203
 NSURLErrorServerCertificateNotYetValid = -1204
 NSURLErrorClientCertificateRejected = -1205
 NSURLErrorClientCertificateRequired = -1206
 NSURLErrorCannotLoadFromNetwork = -2000
 NSURLErrorCannotCreateFile = -3000
 NSURLErrorCannotOpenFile = -3001
 NSURLErrorCannotCloseFile = -3002
 NSURLErrorCannotWriteToFile = -3003
 NSURLErrorCannotRemoveFile = -3004
 NSURLErrorCannotMoveFile = -3005
 NSURLErrorDownloadDecodingFailedMidStream = -3006
 NSURLErrorDownloadDecodingFailedToComplete = -3007
 NSURLErrorAppTransportSecurityRequiresSecureConnection = -1022
 NSURLErrorBackgroundSessionInUseByAnotherProcess = -996
 NSURLErrorBackgroundSessionRequiresSharedContainer = -995
 NSURLErrorBackgroundSessionWasDisconnected = -997
 */



/**
 HTTP Code
 
 1XX - 信息提示
 这些状态代码表示临时的相应。客户端在收到常规相应之前,应准备接收一个或多个1XX相应。
 
 2XX - 成功
 3XX - 重定向
 客户端浏览器必须采取更多操作来实现请求,例如,浏览器可能不得不请求服务器上的不同的页面，或通过代理服务器重复该请求
 4XX - 客户端错误
 发生错误,客户端似乎有问题, 例如, 客户端请求不存在的页面,客户端为提供有效的身份验证信息
 5XX - 服务器错误
 
 200 OK
 201 CREATED 用户新建或修改数据成功
 202 ACCEPTED 表示一个请求已经进入后台排队
 203 NO CONTENT 用户删除数据成功
 
 400 INVALID REQUEST 用户发出的请求有错误,服务器没有进行新建或修改数据的操作
 401 UNAUTHORIZED 表示用户没有权限
 403 FORBIDDEN 表示用户得到授权,但是访问被禁止
 404 NOT FOUND 用户发出的请求针对的是不存在的记录,服务器没有进行操作
 406 NOT ACCEPTABLE 用户请求的格式不可得
 410 GONE 用户请求的资源被永久删除,且不得再得到的
 422 UNPROCESSABLE ENTITY 当创建一个对象时,发生一个验证错误
 
 500 INTERNAL SERVER ERROR 服务器发生错误
 
 */


#define SS_Request_Timeout_Time 20

@interface SSRequestService : NSObject

// 单例
+ (SSRequestService *)sharedRequest;

// POST请求
- (RACSignal *)requestPOSTWithURL:(NSURL *)requestURL alsoParams:(NSDictionary *)params alsoHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields alsoTimeoutInterval:(NSTimeInterval)timeoutInterval;

// POST请求
// 请求头为默认
// 请求超时时间为默认
- (RACSignal *)requestPOSTWithURL:(NSString *)requestURL alsoParams:(NSDictionary *)params;

// POST请求
// 上传图片数据
- (RACSignal *)submitImagesWithURL:(NSString *)requestURL alsoImageSets:(NSArray *)imageSets alsoNames:(NSArray *)names alsoImageFileNames:(NSArray *)fileNames alsoParams:(NSDictionary *)params alsoHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields alsoTimeoutInterval:(NSTimeInterval)timeoutInterval;

// POST请求
// 上传单张图片
- (RACSignal *)submitImageWithURL:(NSString *)requestURL alsoImage:(UIImage *)image alsoImageName:(NSString *)name;

// GET请求
// 请求头为默认
// 请求超时时间为默认
- (RACSignal *)requestGETWithURL:(NSString *)requestURL;


@end
