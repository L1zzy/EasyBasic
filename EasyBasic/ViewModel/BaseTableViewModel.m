//
//  BaseTableViewModel.m
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import "BaseTableViewModel.h"

@implementation BaseTableViewModel

- (void)initialize
{
    @weakify(self);
    self.refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber * page) {
        @strongify(self);
        return [[self refreshDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    self.didSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath * input) {
        @strongify(self);
        return [self didSelectedSignalWithIndexPath:input];
    }];
}

- (RACSignal *)refreshDataSignalWithPage:(NSUInteger)page
{
    return [RACSignal empty];
}

- (RACSignal *)didSelectedSignalWithIndexPath:(NSIndexPath *)indexPath
{
    return [RACSignal empty];
}

@end
