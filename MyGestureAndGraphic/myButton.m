//
//  myButton.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/26.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#import "myButton.h"

@implementation myButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorWithRed:237.0/255 green:143.0/255 blue:73/255 alpha:1.0]; // 背景
        self.layer.cornerRadius = 25.0; // 圆角
        
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
