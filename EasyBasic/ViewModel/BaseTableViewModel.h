//
//  BaseTableViewModel.h
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseTableViewModel : BaseViewModel

@property (nonatomic, copy) NSArray * dataSource;

@property (nonatomic, strong) RACCommand * didSelectedCommand;
@property (nonatomic, strong) RACCommand * refreshDataCommand;

- (RACSignal *)refreshDataSignalWithPage:(NSUInteger)page;
- (RACSignal *)didSelectedSignalWithIndexPath:(NSIndexPath *)indexPath;

@end
