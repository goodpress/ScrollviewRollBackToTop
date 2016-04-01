//
//  ViewController.m
//  RollTopBtn
//
//  Created by huoen.wyk on 4/1/16.
//  Copyright (c) 2016 huoen.wyk. All rights reserved.
//


#import <Masonry/View+MASAdditions.h>
#import "ViewController.h"
#import "RollTop.h"


@interface ViewController ()
@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIView *container;
@end

@implementation ViewController


#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    self.scrollView.contentSize = self.container.frame.size;
    CGRect f = self.container.frame;
    NSLog(@"===self.container.frame origin.x:%d ,origin.y:%d , origin.size.width:%d, origin.size.height:%d", (int) f.origin.x, (int) f.origin.y, (int) f.size.width, (int) f.size.height);
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark method

- (void)addScrollView {
    if (!self.scrollView) {
        __weak typeof(self) weakSelf = self;
//初始化
        self.scrollView = [[UIScrollView alloc] init];
        UIView *tmpView = [[UIView alloc] init];
        self.container = [[UIView alloc] init];

        [self.container addSubview:tmpView];
        [self.scrollView addSubview:self.container];
        [self.view addSubview:self.scrollView];

//设置Layout
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.center.mas_equalTo(weakSelf.view);
            maker.size.mas_equalTo(weakSelf.view);
        }];

        [self.container mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.top.left.mas_equalTo(weakSelf.scrollView);
            CGRect screenBounds = [[UIScreen mainScreen] bounds];
            maker.width.mas_equalTo(screenBounds.size.width);
            maker.height.mas_equalTo(3000);
        }];

        //用来指示是否滑动
        [tmpView mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.top.left.mas_equalTo(weakSelf.container).offset(20);
            maker.size.mas_equalTo(CGSizeMake(40, 40));
        }];

//设置颜色
        [self.scrollView setBackgroundColor:[UIColor whiteColor]];
        [self.container setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
        [tmpView setBackgroundColor:[UIColor whiteColor]];

//设置contentsize
        self.scrollView.delegate = self;
    }
}

#pragma mark ScrollviewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    RollTop *rollTop = [RollTop initWithScrollView:self.scrollView];
    if (scrollView.contentOffset.y > (screenBounds.size.height / 2) && !rollTop.on) {
        [rollTop ShowBtn];
        NSLog(@" roll : [rollTop ShowBtn]");
    } else if (scrollView.contentOffset.y < (screenBounds.size.height / 2) && rollTop.on) {
        [rollTop HidBtn];
        NSLog(@" roll : [rollTop hidBtn]");
    }
}


@end