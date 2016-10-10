//
//  BaseViewModelProtocol.h
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol BaseViewModelProtocol <NSObject>

@required

- (void)initialize;

@end