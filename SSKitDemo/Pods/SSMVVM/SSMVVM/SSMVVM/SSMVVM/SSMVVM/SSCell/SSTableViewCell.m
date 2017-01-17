//
//  SSTableViewCell.m
//  SSKit
//
//  Created by Quincy Yan on 16/4/7.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTableViewCell.h"

@implementation SSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)bindWithDataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath {}

- (void)bindWithViewModel:(SSViewModel *)viewModel indexPath:(NSIndexPath *)indexPath {}

- (void)bindWithViewModel:(SSViewModel *)viewModel dataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath{};

+ (CGFloat)cellHeightWithModel:(NSObject *)model {return 44;}

@end
