//
//  BaseTableViewController.m
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewModel.h"

@interface BaseTableViewController ()

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) BaseTableViewModel * viewModel;

@end

@implementation BaseTableViewController
@synthesize viewModel = _viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    BaseTableViewController * viewController = [super allocWithZone:zone];
    return viewController;
}

- (id<BaseViewProtocol>)initWithViewModel:(id<BaseViewModelProtocol>)viewModel
{
    self = [super initWithViewModel:viewModel];
    return self;
}

- (void)bindViewModel
{
    @weakify(self);
    [RACObserve(self.viewModel,dataSource) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)viewSetting
{
    [super viewSetting];
    self.tableView.backgroundColor = BACKGROUND_COLOR;
}

- (void)makeConstaints
{
    [super makeConstaints];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(@0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView=[[UIView alloc]init];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate && DataSource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //按照作者最后的意思还要加上下面这一段
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.viewModel.dataSource.count == 0) {
        return 0;
    }
    else {
        id dataSourceItem = self.viewModel.dataSource[0];
        return [dataSourceItem isKindOfClass:[NSArray class]] ? self.viewModel.dataSource.count : 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id cells = self.viewModel.dataSource[section];
    return [cells isKindOfClass:[NSArray class]] ? [(NSArray *)cells count] : [self.viewModel.dataSource count];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.viewModel && self.viewModel.didSelectedCommand) {
        [self.viewModel.didSelectedCommand execute:indexPath];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _tableView.contentOffset = CGPointMake(0, 0);
    }
    return _tableView;
}

@end
