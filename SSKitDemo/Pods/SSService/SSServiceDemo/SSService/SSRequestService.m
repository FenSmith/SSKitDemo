//
//  SSRequestService.m
//  SSKit
//
//  Created by Quincy Yan on 16/5/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSRequestService.h"

@implementation SSRequestService

+ (SSRequestService *)sharedRequest {
    static SSRequestService *requester = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requester = [[SSRequestService alloc] init];
    });
    return requester;
}

- (RACSignal *)requestGETWithURL:(NSString *)requestURL {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil]];
        [manager GET:requestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
            [self manageWithRes:responseObject alsoError:nil alsoParams:nil alsoRequestURL:[NSURL URLWithString:requestURL] alsoSubscribe:subscriber];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self manageWithRes:nil alsoError:error alsoParams:nil alsoRequestURL:[NSURL URLWithString:requestURL] alsoSubscribe:subscriber];
        }];
        return nil;
    }];
}

- (RACSignal *)requestPOSTWithURL:(NSString *)requestURL alsoParams:(NSDictionary *)params {
    return [self requestPOSTWithURL:[NSURL URLWithString:requestURL relativeToURL:[NSURL URLWithString:[SSAppHandler sharedHander].server]]
                         alsoParams:params
               alsoHTTPHeaderFields:[SSAppHandler sharedHander].ssah_HTTPHeaderFields
                alsoTimeoutInterval:SS_Request_Timeout_Time];
}

- (RACSignal *)requestPOSTWithURL:(NSURL *)requestURL alsoParams:(NSDictionary *)params alsoHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields alsoTimeoutInterval:(NSTimeInterval)timeoutInterval {
    return [self requestWithURL:requestURL
                     alsoParams:[[SSAppHandler sharedHander] ssah_encryptParams:params]
           alsoHTTPHeaderFields:HTTPHeaderFields
            alsoTimeoutInterval:timeoutInterval
                     alsoMethod:@"POST"];
}

- (RACSignal *)submitImageWithURL:(NSString *)requestURL alsoImage:(UIImage *)image alsoImageName:(NSString *)name {
    return [self submitImagesWithURL:requestURL
                       alsoImageSets:@[image]
                           alsoNames:@[name]
                  alsoImageFileNames:@[[NSString stringWithFormat:@"%@.png",image]]
                          alsoParams:[[SSAppHandler sharedHander] ssah_encryptParams:nil]
                alsoHTTPHeaderFields:[SSAppHandler sharedHander].ssah_HTTPHeaderFields
                 alsoTimeoutInterval:SS_Request_Timeout_Time];
}

- (void)managerWithHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields
                    timeoutInterval:(NSTimeInterval)timeoutInterval
                              block:(void (^ )(AFURLSessionManager *manager, AFHTTPRequestSerializer *request))block{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy.allowInvalidCertificates = YES;
//    [manager setSecurityPolicy:securityPolicy];
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    manager.responseSerializer = response;
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    request.timeoutInterval = timeoutInterval;
    if (HTTPHeaderFields && [HTTPHeaderFields allKeys].count > 0) {
        for (NSString *key in [HTTPHeaderFields allKeys]) {
            [request setValue:HTTPHeaderFields[key] forHTTPHeaderField:key];
        }
    }
    block (manager,request);
}

- (RACSignal *)requestWithURL:(NSURL *)requestURL
                   alsoParams:(NSDictionary *)params
         alsoHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields
          alsoTimeoutInterval:(NSTimeInterval)timeoutInterval
                   alsoMethod:(NSString *)method {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self managerWithHTTPHeaderFields:HTTPHeaderFields timeoutInterval:timeoutInterval block:^(AFURLSessionManager *manager, AFHTTPRequestSerializer *request) {
            NSError *reqError;
            NSMutableURLRequest *URLRequest = [request requestWithMethod:method
                                                               URLString:requestURL.absoluteString
                                                              parameters:params
                                                                   error:&reqError];
            if (reqError) {
                NSLog(@"\n NSMutableURLRequest 设置错误: %@",reqError);
            }
            NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:URLRequest
                                                        completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
                                                            [self manageWithRes:responseObject alsoError:error alsoParams:params alsoRequestURL:requestURL alsoSubscribe:subscriber];
                                                        }];
            
            [dataTask resume];
        }];
        return nil;
    }];
}

- (RACSignal *)submitImagesWithURL:(NSString *)requestURL
                     alsoImageSets:(NSArray *)imageSets
                         alsoNames:(NSArray *)names
                alsoImageFileNames:(NSArray *)fileNames
                        alsoParams:(NSDictionary *)params
              alsoHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields
               alsoTimeoutInterval:(NSTimeInterval)timeoutInterval {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self managerWithHTTPHeaderFields:HTTPHeaderFields timeoutInterval:timeoutInterval block:^(AFURLSessionManager *manager, AFHTTPRequestSerializer *request) {
            NSError *reqError;
            NSURL *submitURL = [NSURL URLWithString:requestURL relativeToURL:[NSURL URLWithString:[SSAppHandler sharedHander].server]];
            NSMutableURLRequest *request2 = [request multipartFormRequestWithMethod:@"POST"
                                                                          URLString:submitURL.absoluteString
                                                                         parameters:params
                                                          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                                              for (int i = 0; i < imageSets.count; i++) {
                                                                  id image = [imageSets objectAtIndex:i];
                                                                  id name = [names objectAtIndex:i];
                                                                  id fileName = fileNames.count > i ? [fileNames objectAtIndex:i] : [NSString stringWithFormat:@"%@.png",image];
                                                                  if ([image isKindOfClass:[UIImage class]]) {
                                                                      NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
                                                                      if (imageData.length > 1000000) {
                                                                          imageData = UIImageJPEGRepresentation(image,0.5f);
                                                                      }
                                                                      [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
                                                                  }
                                                              }
                                                          } error:&reqError];
            
            if (reqError) {
                NSLog(@"\n NSMutableURLRequest 设置错误: %@",reqError);
            }
            
            NSURLSessionUploadTask *dataTask = [manager uploadTaskWithStreamedRequest:request2
                                                                             progress:nil
                                                                    completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                                                                                                                                                                    [self manageWithRes:responseObject alsoError:error alsoParams:params alsoRequestURL:submitURL alsoSubscribe:subscriber];
                                                                    }];
            [dataTask resume];
        }];
        return nil;
    }];
}

- (void)manageWithRes:(id)responseObject
            alsoError:(NSError *)error
           alsoParams:(NSDictionary *)params
       alsoRequestURL:(NSURL *)requestURL
        alsoSubscribe:(id<RACSubscriber>)subscriber {
    id result = [[SSAppHandler sharedHander] ssah_filterCallback:responseObject error:error params:params requestURL:requestURL];
    if ([result isKindOfClass:[NSError class]]) {
        [subscriber sendError:result];
    } else {
        [subscriber sendNext:result];
    }
    [subscriber sendCompleted];
}


@end
