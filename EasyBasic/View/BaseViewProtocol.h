//
//  BaseViewProtocol.h
//  EasyVideo
//
//  Created by Easy.Lin on 16/3/20.
//  Copyright © 2016年 com.Easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import "BaseViewModelProtocol.h"

#define DEFAULT_THEME    [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]
#define BACKGROUND_COLOR [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define navHeight    64

@protocol BaseViewProtocol <NSObject>

@required
- (id<BaseViewProtocol>)initWithViewModel:(id<BaseViewModelProtocol>)viewModel;

@property (nonatomic, strong, readonly) id<BaseViewModelProtocol> viewModel;

@optional

- (void)bindViewModel;
- (void)viewSetting;
- (void)makeConstaints;

@end
