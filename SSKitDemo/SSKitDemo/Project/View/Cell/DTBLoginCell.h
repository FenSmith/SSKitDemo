//
//  HZLoginCell.h
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSKit/SSTableViewCell.h>

@interface DTBLoginCell : SSTableViewCell

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,copy) TextCallback callback;

@end
