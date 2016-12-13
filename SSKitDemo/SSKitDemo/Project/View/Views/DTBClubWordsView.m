//
//  DTBClubWordsView.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/23.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubWordsView.h"

@interface DTBClubWordsView()
@end

@implementation DTBClubWordsView

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (!self) return nil;
    
    [self addSubview:self.wordsView];
    [self.wordsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self);
//        make.bottom.equalTo(self).offset(-8);
        make.edges.equalTo(self);
    }];
    
    return self;
}

- (SSPlaceHolderTextView *)wordsView {
    if (!_wordsView) {
        _wordsView = [[SSPlaceHolderTextView alloc] init];
        _wordsView.placeHolder = @"内容";
        _wordsView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
        _wordsView.font = [UIFont systemFontOfSize:15];
        _wordsView.textColor = SSNormalColor;
        _wordsView.placeHolderTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor colorWithRGB:@"199,199,199"],NSForegroundColorAttributeName,
                                                [UIFont systemFontOfSize:15],NSFontAttributeName,nil];
    }
    return _wordsView;
}

@end
