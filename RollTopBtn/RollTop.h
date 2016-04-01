//
// Created by huoen.wyk on 4/1/16.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIScrollView;

@interface RollTop : NSObject
@property (nonatomic) BOOL on;
+(instancetype)initWithScrollView:(UIScrollView *)scrollView;
- (void)ShowBtn;
- (void)HidBtn;
@end