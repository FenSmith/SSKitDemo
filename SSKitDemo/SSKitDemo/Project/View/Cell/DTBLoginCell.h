//
//  HZLoginCell.h
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <SSMVVM/SSMVVM.h>

@interface DTBLoginCell : SSTableViewCell

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,copy) SSOnlyTextBlock callback;

@end
