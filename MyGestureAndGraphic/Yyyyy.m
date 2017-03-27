//
//  Yyyyy.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/25.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#import "Yyyyy.h"
#define redColor [UIColor redColor];
@implementation Yyyyy

- (void)drawRect:(CGRect)rect {
    
//    [self myLine];
    [self myCoordinateY];
}

#pragma mark - 坐标轴 Y
- (void)myCoordinateY
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    [self myCoordinateY:context];
}
- (void) myCoordinateY:(CGContextRef)context{
    // y
    CGContextMoveToPoint(context,50, 600);
    CGContextAddLineToPoint(context, 50, 40);
    CGContextMoveToPoint(context,45, 45);
    CGContextAddLineToPoint(context, 50, 40);
    CGContextAddLineToPoint(context, 55, 45);
    
    for (int i=6; i>0; i--) {
        CGContextMoveToPoint(context, 50, i*100);
        CGContextAddLineToPoint(context, 60, i*100);
    }
    // 添加Y轴 文字
    [self YText];
    
    CGContextStrokePath(context);
    
}
- (void) YText {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // 添加Y轴 文字
    for (int i=7; i>0; i--) {
        NSString *str = [NSString stringWithFormat:@"%d",120-i*20];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        // 文字大小 截断 颜色
        NSDictionary *dic = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:12],
                              NSParagraphStyleAttributeName:paragraphStyle,
                              NSForegroundColorAttributeName:[UIColor magentaColor]
                              };
        if (i<7) {
            [str drawAtPoint:CGPointMake(20, i*100-8) withAttributes:dic];
        }else{
            str = @"水位/m";
            [str drawAtPoint:CGPointMake(5, 50) withAttributes:dic];
        }
    }
    CGContextRestoreGState(context);
}
#pragma mark - 直线
- (void) myLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);
    [self myLine:context];
    
    CGContextSetRGBStrokeColor(context, 0.5, 0, 0.5, 1);
    [self myLine2:context];
}
- (void) myLine:(CGContextRef) context
{
    CGContextMoveToPoint(context, 30, 50);
    CGContextAddLineToPoint(context, 30, 500);
    // 渲染
    CGContextStrokePath(context);
}
- (void) myLine2:(CGContextRef) context
{
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 20, 400);
    // 渲染
    CGContextStrokePath(context);
}

@end

