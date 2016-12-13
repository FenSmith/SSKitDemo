//
//  SSLocationService.h
//  SSKit
//
//  Created by Quincy Yan on 16/5/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ serviceSearchedBlock)(NSString *city);

@interface SSLocationService : NSObject

- (void)startServiceWithBlock:(serviceSearchedBlock)block;
- (void)verifyUserLocationState;

@end
