//
// Created by huoen.wyk on 4/1/16.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "RollTop.h"
#import "CustomBtn.h"
#import "View+MASAdditions.h"

@class UIButton;

@interface RollTop ()
@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIButton *btn;
@end;

@implementation RollTop {

}

+ (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (scrollView) {
        static RollTop *rollTop;
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            rollTop = [[RollTop alloc] init];
            rollTop.scrollView = scrollView;
            NSLog(@"init RollTop");
        });
        return rollTop;
    }
    return nil;
}

#pragma mark getter setter

- (UIButton *)getBtn {
    static  UIButton *tmpBtn;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSLog(@"init btn");
        tmpBtn = [CustomBtn buttonWithType:UIButtonTypeRoundedRect];
        [tmpBtn setTitle:@"回顶" forState:UIControlStateNormal];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        NSAssert(tmpBtn, @"初始化 btn 失败");
        [keyWindow addSubview:tmpBtn];
        [tmpBtn mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.right.mas_equalTo(keyWindow.mas_right).offset(-20);
            maker.bottom.mas_equalTo(keyWindow.mas_bottom).offset(-20);
            maker.size.mas_equalTo(CGSizeMake(40, 40));
        }];
//        tmpBtn.alpha = 0;

    });
    [tmpBtn setBackgroundColor:[UIColor whiteColor]];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToTop:)];
    [tmpBtn addGestureRecognizer:recognizer];
    self.btn = tmpBtn;
    return self.btn;
}

#pragma mark method

- (void)ShowBtn {
    if (!self.on) {
        self.on = YES;
        self.btn = [self getBtn];
        [UIView animateWithDuration:1 animations:^{
            self.btn.alpha = 1;
        }];
    }
}

- (void)HidBtn {
    if (self.on) {
        self.on = NO;
        self.btn = [self getBtn];
        [UIView animateWithDuration:1 animations:^{
            self.btn.alpha = 0;
        }];
    }
}

- (void)scrollToTop:(UITapGestureRecognizer *)recognizer{
    CGPoint p = self.scrollView.contentOffset;
    p.y = - self.scrollView.contentInset.top;

    [self.scrollView setContentOffset:p];

}
@end