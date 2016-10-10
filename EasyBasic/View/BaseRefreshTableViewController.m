//
//  BaseRefreshTableViewController.m
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/22.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import "BaseRefreshTableViewController.h"
#import "BaseTableViewModel.h"

@interface BaseRefreshTableViewController ()

@property (nonatomic, strong) BaseTableViewModel * viewModel;
@property (nonatomic, strong) MJRefreshNormalHeader * header;
@property (nonatomic, strong) MJRefreshBackNormalFooter * footer;

@end

@implementation BaseRefreshTableViewController
@synthesize viewModel = _viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    BaseRefreshTableViewController * viewController = [super allocWithZone:zone];
    return viewController;
}

- (id<BaseViewProtocol>)initWithViewModel:(id<BaseViewModelProtocol>)viewModel
{
    self = [super initWithViewModel:viewModel];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = self.header;
    self.tableView.mj_footer = self.footer;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewModel.refreshDataCommand execute:nil];
}

- (void)bindViewModel
{
    [super bindViewModel];
    @weakify(self);
    if ([self.viewModel respondsToSelector:@selector(refreshDataCommand)]) {
        [self.viewModel.refreshDataCommand.executing subscribeNext:^(NSNumber *x) {
            @strongify(self);
            if (![x boolValue]) {
                [self.tableView.mj_header endRefreshing];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter
- (MJRefreshNormalHeader *)header
{
    if (!_header) {
        @weakify(self);
        _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            //[[self.viewModel.refreshDataCommand execute:nil] subscribeNext:^(id x) {
                //[self.tableView.mj_header endRefreshing];
            //} error:^(NSError *error) {
                //[self.tableView.mj_header endRefreshing];
            //}];
            [self.viewModel.refreshDataCommand execute:nil];
        }];
        _header.lastUpdatedTimeLabel.hidden = YES;
        _header.stateLabel.hidden = YES;
    }
    return _header;
}

- (MJRefreshBackNormalFooter *)footer
{
    if (!_footer) {
        @weakify(self);
        _footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_footer endRefreshing];
            });
        }];
    }
    return _footer;
}

@end
