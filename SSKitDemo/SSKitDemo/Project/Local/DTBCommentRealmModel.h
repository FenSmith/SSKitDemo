//
//  DTBCommentRealmModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/12/6.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Realm/Realm.h>

@interface DTBCommentRealmModel : RLMObject

@property NSString *title;
@property NSString *content;
@property NSString *images;

@end
