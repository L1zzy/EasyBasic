//
//  BaseViewController.m
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewModel.h"

@interface BaseViewController ()

@property (nonatomic, strong) BaseViewModel * viewModel;

@end

@implementation BaseViewController
@synthesize viewModel = _viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    BaseViewController * viewController = [super allocWithZone:zone];
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController);
        [viewController bindViewModel];
        [viewController viewSetting];
        [viewController makeConstaints];
    }];
    return viewController;
}

- (id<BaseViewProtocol>)initWithViewModel:(id<BaseViewModelProtocol>)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewSetting
{
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)bindViewModel
{
    
}

- (void)makeConstaints
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
