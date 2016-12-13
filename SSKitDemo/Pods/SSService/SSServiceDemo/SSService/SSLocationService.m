//
//  SSLocationService.m
//  SSKit
//
//  Created by Quincy Yan on 16/5/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSLocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface SSLocationService() <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,copy) serviceSearchedBlock block;
@end

@implementation SSLocationService

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _manager = [[CLLocationManager alloc] init];
    
    return self;
}

- (void)startServiceWithBlock:(serviceSearchedBlock)block{
    NSString *alwaysKey = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"];
    NSString *whenInUseKey = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if (alwaysKey) {
            [_manager requestAlwaysAuthorization];
        } else if(whenInUseKey) {
            [_manager requestWhenInUseAuthorization];
        }
        _block = block;
        _manager.delegate = self;
        [_manager startMonitoringSignificantLocationChanges];
        [_manager startUpdatingLocation];
    } else {
//        [self verifyUserLocationState];
    }
}

- (void)verifyUserLocationState {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
    } else {
        // 定位失败
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"heading:%@",newHeading);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    __weak typeof(self) wself = self;
    
    [coder reverseGeocodeLocation:[locations firstObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if (placemarks && placemarks.count > 0) {
                CLPlacemark *placeMark = [placemarks firstObject];
                if (wself.block && placeMark.locality && placeMark.locality.length > 0) {
                    wself.block(placeMark.locality);
                    NSLog(@"placemarks:%@",placeMark.addressDictionary);
                    wself.block = nil;
                    wself.manager.delegate = nil;
                    [wself.manager stopUpdatingLocation];
                    [wself.manager stopMonitoringSignificantLocationChanges];
                }
            } else {
                NSLog(@"placemarks为空");
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}

@end
