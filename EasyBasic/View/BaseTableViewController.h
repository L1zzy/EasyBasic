//
//  BaseTableViewController.h
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewProtocol.h"

@interface BaseTableViewController : BaseViewController <BaseViewProtocol,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView * tableView;

@property (nonatomic, strong) RACCommand * didSelectedCommand;

- (void)viewSetting;

@end