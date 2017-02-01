//
//  SSTableViewController.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/29.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTableViewController.h"
#import "SSTableViewModel.h"
#import "SSTableViewCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <SSWrapper/SSPullRefresh.h>

@interface SSTableViewController()
/**
 当‘dataSource’数组变化的时候,会自动‘reload’
 dataSource基本构成为一个section -> @[],
 */
@property (nonatomic,strong) SSTableViewModel *viewModel;

@end

@implementation SSTableViewController

- (instancetype)initWithViewModel:(SSTableViewModel *)viewModel{
    self = [super initWithViewModel:viewModel];
    if (self) {
        if (viewModel.isLoadDataInitially) {
            @weakify(self);
            [[self rac_signalForSelector:@selector(bindViewModel)]
             subscribeNext:^(id x) {
                 @strongify(self);
                 if (self.viewModel.isAllowLoadData) {
                     [self.tableView.reloadView startRefreshing];
                 }
             }];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)bindViewModel{
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, dataSource).distinctUntilChanged.deliverOnMainThread
     subscribeNext:^(id x) {
         @strongify(self);
         [self.tableView reloadData];
     }];
    
    if (self.viewModel.isAllowLoadData) {
        if ([self respondsToSelector:@selector(dataRequestStartOnlyOnce)]) {
            [self dataRequestStartOnlyOnce];
        }
        
        [self.tableView sspr_insertReloadViewAttachCallback:^{
            @strongify(self);
            self.viewModel.page = 0;
            if ([self respondsToSelector:@selector(dataRequestStart)]) {
                [self dataRequestStart];
            }
            
            [[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page + 1)]
             subscribeNext:^(id x) {
                 @strongify(self);
                 if ([self respondsToSelector:@selector(dataRequestSuccess:)]) {
                     [self dataRequestSuccess:x];
                 }
                 [self.tableView.reloadView stopRefreshing];
             } error:^(NSError *error) {
                 @strongify(self);
                 if ([self respondsToSelector:@selector(dataRequestError:)]) {
                     [self dataRequestError:error];
                 }
                 [self.tableView.reloadView stopRefreshing];
             } completed:^{
                 @strongify(self);
                 if ([self respondsToSelector:@selector(dataRequestFinished)]) {
                     [self dataRequestFinished];
                 }
                 [self.tableView.reloadView stopRefreshing];
             }];
        }];
    }
    
    if (self.viewModel.isAllowLoadAdditionalData) {
        [self.tableView sspr_insertLoadingViewAttachCallback:^{
            @strongify(self);
            if ([self respondsToSelector:@selector(dataRequestStart)]) {
                [self dataRequestStart];
            }
            
            [[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page + 1)]
             subscribeNext:^(id x) {
                 @strongify(self);
                 if ([self respondsToSelector:@selector(dataRequestSuccess:)]) {
                     [self dataRequestSuccess:x];
                 }
                 [self.tableView.loadingView stopRefreshing];
             } error:^(NSError *error) {
                 @strongify(self);
                 if ([self respondsToSelector:@selector(dataRequestError:)]) {
                     [self dataRequestError:error];
                 }
                 [self.tableView.loadingView stopRefreshing];
             } completed:^{
                 @strongify(self);
                 if ([self respondsToSelector:@selector(dataRequestFinished)]) {
                     [self dataRequestFinished];
                 }
                 [self.tableView.loadingView stopRefreshing];
             }];
        }];
    }
}

- (void)dataRequestStart {
}

- (void)dataRequestStartOnlyOnce {
}

- (void)dataRequestFinished {
}

- (void)dataRequestSuccess:(id)params {
}

- (void)dataRequestError:(NSError *)error {
}

- (void)setHeaderView:(UIView *)headerView {
    self.tableView.tableHeaderView = headerView;
}

- (void)setSheetView:(UIView *)sheetView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(sheetView.frame) + CGRectGetMinY(sheetView.frame))];
    [footView addSubview:sheetView];
    
    [sheetView setFrame:CGRectMake((CGRectGetWidth(self.view.frame) - CGRectGetWidth(sheetView.frame)) / 2,
                                   CGRectGetMinY(sheetView.frame),
                                   CGRectGetWidth(sheetView.frame),
                                   CGRectGetHeight(sheetView.frame))];
    self.tableView.tableFooterView = footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SSTableViewCell cellHeightWithModel:self.viewModel.dataSource[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectedCommand execute:indexPath];
}

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

@end
