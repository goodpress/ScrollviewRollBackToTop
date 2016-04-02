//
//  CustomBtn.m
//  RollTopBtn
//
//  Created by huoen.wyk on 4/2/16.
//  Copyright © 2016 huoen.wyk. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.cornerRadius = rect.size.width / 2;
    self.layer.masksToBounds = YES;

}
@end
