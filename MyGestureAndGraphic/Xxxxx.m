//
//  Quartz2d.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/25.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#define blueColor [UIColor blueColor]
#define redColor [UIColor redColor]
#import "Xxxxx.h"
@implementation Xxxxx

//NSMutableArray *linePoints;     // 存储折线 X坐标
NSMutableDictionary *crossPointDic; // 存储折线 Y坐标
NSMutableArray *xPoints;        // 存储X轴  X坐标
NSMutableArray *linePointsText; // 存储折线 水位文字
NSMutableDictionary *linePointsTextDic;
NSMutableArray *xPointsText;    // 存储X轴  时间文字
NSMutableDictionary *xPointsTextDic;

CGContextRef context;
int margin = 40;
int pointsNum = 18;
NSString *str; // X轴文字

- (void)drawRect:(CGRect)rect {
    [self myRect];
    [self myArc];
    //    // 获取上下文
    //    context = UIGraphicsGetCurrentContext();
    
    //    [self line:20 context:context];
    [self drawX];
}

#pragma mark - 坐标轴x
- (void)drawX
{
    context = UIGraphicsGetCurrentContext();
    // x轴 折线
    if (self.scale == 1.0) {
        
        [self myUpdateCoordinate:context margin:40 pointsNum:18 ];// 初始X坐标
        [self myUpdateLine2:context margin:40 pointsNum:18 ]; // 初始折线
    }
    if (self.scale > 0.79 && self.scale <= 0.8) {
        self.scale = 0.8;
        //        [self myUpdateCoordinate:context margin:40 pointsNum:18 ];// 更新X坐标
        [self myUpdateLine2:context margin:40 pointsNum:18 ]; // 更新折线
    }
    if(self.scale > 0.59 && self.scale <= 0.6) {
        self.scale = 0.6;
        //        [self myUpdateCoordinate:context margin:40 pointsNum:18 ];// 更新X坐标
        [self myUpdateLine2:context margin:40 pointsNum:18 ]; // 更新折线
    }
    if(self.scale > 0.39 && self.scale <= 0.4) {
        self.scale = 0.4;
        //        [self myUpdateCoordinate:context margin:40 pointsNum:18 ];// 更新X坐标
        [self myUpdateLine2:context margin:40 pointsNum:18 ]; // 更新折线
    }
    if (self.scale > 0.19 && self.scale <= 0.2) {
        self.scale = 0.2;
        //        [self myUpdateCoordinate:context margin:40 pointsNum:18 ];// 更新X坐标
        [self myUpdateLine2:context margin:40 pointsNum:18 ]; // 更新折线
    }
    [self myUpdateCoordinate:context margin:margin pointsNum:pointsNum];
}
- (void) myUpdateCoordinate:(CGContextRef)context margin:(int) margin pointsNum:(int) pointsNum
{
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 1, 1, 0.2, 1);
    CGContextSetLineWidth(context, 1);
    // 储存X轴X坐标 初始化
    xPoints = [[NSMutableArray alloc] init];
    // 储存X轴时间文字 初始化
    xPointsText = [[NSMutableArray alloc] init];
    xPointsTextDic = [[NSMutableDictionary alloc] init];
    //    NSLog(@"===x坐标开始===");
    // 添加X轴
    CGContextMoveToPoint(context,0, 600);
    CGContextAddLineToPoint(context, 750 * self.scale, 600);
    CGContextMoveToPoint(context,745 * self.scale, 595);
    CGContextAddLineToPoint(context, 750 * self.scale, 600);
    CGContextAddLineToPoint(context, 745 * self.scale, 605);
    
    for (int i=0; i<pointsNum; i++) {
        // 添加X轴时间文字
        if (self.scale > 0.8) {
            // 储存X轴X坐标
            CGFloat x = (10+i*margin) * self.scale;
            [xPoints addObject:[NSNumber numberWithFloat:x]];
            
            //            // 委托 传值
            //            [self.delegate passXPoints:xPoints];
            //            for (NSNumber *num in xPoints) {
            //                NSLog(@"xPoints%@",num);
            //            }
            
            CGContextMoveToPoint(context, x, 600); // 刻度
            CGContextAddLineToPoint(context, x, 595);
            // 添加X轴时间文字
            [self myCoordinateMargin:margin pointsNum:pointsNum number:18.0 i:i];
            //            NSLog(@"str-------%@",str);
            // 存储X坐标文字 用字典？数组 还是接收的时候将数组转化为字典/////////////////////////
            [xPointsText addObject:str];
            //            [xPointsTextDic setValue:str forKey:[NSString stringWithFormat:@"%d",i]];
            NSString *akey = [NSString stringWithFormat:@"%d",i];
            [xPointsTextDic setObject:str forKey:akey];
            
            //            NSString *text1 = [xPointsTextDic objectForKey:@"0"];
            //            NSLog(@"text1-------%@",text1);
            
            //            // 传值
            //            [self.delegate passXPointsText:xPointsText];
            //            [self.delegate passXPointsTextDic:xPointsTextDic];
            //            for (NSString *str in xPointsText) {
            //                NSLog(@"xText%@",str);
            //            }
            
        }
        if (self.scale >0.6 && self.scale <= 0.8) {
            // 添加X轴文字
            CGContextMoveToPoint(context, (10+i*margin) * self.scale, 600); // 刻度
            CGContextAddLineToPoint(context, (10+i*margin) * self.scale, 590);
            [self myCoordinateMargin:margin pointsNum:pointsNum number:9.0 i:i];
        }
        if (self.scale >0.4 && self.scale <= 0.6) {
            if (i%2 == 0) {
                // 添加X轴文字
                CGContextMoveToPoint(context, (10+i*margin) * self.scale, 600); // 刻度
                CGContextAddLineToPoint(context, (10+i*margin) * self.scale, 590);
                [self myCoordinateMargin:margin pointsNum:pointsNum number:8.0 i:i];
            }
        }
        if (self.scale >0.2 && self.scale <= 0.4) {
            if (i%3 == 0) {
                // 添加X轴文字
                CGContextMoveToPoint(context, (10+i*margin) * self.scale, 600); // 刻度
                CGContextAddLineToPoint(context, (10+i*margin) * self.scale, 590);
                [self myCoordinateMargin:margin pointsNum:pointsNum number:7.0 i:i];
            }
        }
        if (self.scale >0.0 && self.scale <= 0.2) {
            if (i%5 == 0) {
                // 添加X轴文字
                CGContextMoveToPoint(context, (10+i*margin) * self.scale, 600); // 刻度
                CGContextAddLineToPoint(context, (10+i*margin) * self.scale, 590);
                [self myCoordinateMargin:margin pointsNum:pointsNum number:6.0 i:i];
            }
        }
    }
    // 渲染
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    // 委托 传值
    [self.delegate passXPoints:xPoints];
    // 传值
    [self.delegate passXPointsText:xPointsText];
    [self.delegate passXPointsTextDic:xPointsTextDic];
    
}
#pragma mark - X轴 文字
- (void) myCoordinateMargin:(int) margin pointsNum:(int) pointsNum  number:(float) n
                          i:(int) i;
{
    CGContextSaveGState(context);
    //    // 添加X轴文字
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle]mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    //    // 文字大小 截断 颜色
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:10],
                          NSParagraphStyleAttributeName:paragraphStyle,
                          NSForegroundColorAttributeName:[UIColor greenColor]
                          };
    //
    str = [NSString stringWithFormat:@"%2.1f",3+i%pointsNum/n];
    [str drawAtPoint:CGPointMake( (i*margin) * self.scale, 605) withAttributes:dic];
    CGContextRestoreGState(context);
}

#pragma mark - 折线
- (void)drawLine2
{
    [self myUpdateLine2:context margin:margin pointsNum:pointsNum];
}
- (void) myUpdateLine2:(CGContextRef) context margin:(int) margin pointsNum:(int) pointsNum {
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextSetLineWidth(context, 1.0);
    
    crossPointDic = [[NSMutableDictionary alloc] init];// 拐点字典 X坐标等于X轴X坐标 存储Y坐标就可以
    CGFloat x = (5+685-17*40) * self.scale;
    CGFloat y = 505-sin(pointsNum-1)*50;
    
    CGContextMoveToPoint(context, x, y);
    //    NSLog(@"===折线===");
    for (int i=pointsNum-1; i>=0; i--) {
        x = (5+685-i*margin) * self.scale;
        y = 505-sin(i)*50;
        
        NSNumber *Y = [NSNumber numberWithFloat:y];
        NSString *akey = [NSString stringWithFormat:@"%d",i];
        [crossPointDic setObject:Y forKey:akey];// 还是用字典 存储拐点Y坐标
        CGContextAddLineToPoint(context, x, y);
    }
    // 委托 传值
    [self.delegate passLinePointsDic:crossPointDic];
    
    {
        //    CGContextAddLineToPoint(context, 5+(685-17*margin)*scale, 475);
        //    CGContextAddLineToPoint(context, 5+(685-16*margin)*scale, 455);
        //    CGContextAddLineToPoint(context, 5+(685-15*margin)*scale, 480);
        //    CGContextAddLineToPoint(context, 5+(685-14*margin)*scale, 465);
        //    CGContextAddLineToPoint(context, 5+(685-13*margin)*scale, 455);
        //    CGContextAddLineToPoint(context, 5+(685-12*margin)*scale, 465);
        //    CGContextAddLineToPoint(context, 5+(685-11*margin)*scale, 470);
        //    CGContextAddLineToPoint(context, 5+(685-10*margin)*scale, 455);
        //    CGContextAddLineToPoint(context, 5+(685-9*margin) *scale, 465);
        //    CGContextAddLineToPoint(context, 5+(685-8*margin) *scale, 485);
        //    CGContextAddLineToPoint(context, 5+(685-7*margin) *scale, 475);
        //    CGContextAddLineToPoint(context, 5+(685-6*margin) *scale, 495);
        //    CGContextAddLineToPoint(context, 5+(685-5*margin) *scale, 480);
        //    CGContextAddLineToPoint(context, 5+(685-4*margin) *scale, 455);
        //    CGContextAddLineToPoint(context, 5+(685-3*margin) *scale, 460);
        //    CGContextAddLineToPoint(context, 5+(685-2*margin) *scale, 468);
        //    CGContextAddLineToPoint(context, 5+(685-1*margin) *scale, 483);
    }
    [self myTextMargin:margin pointsNum:pointsNum scale:self.scale]; // 折线 文字
    CGContextStrokePath(context); // 渲染
    CGContextRestoreGState(context);
}
#pragma mark - 折线 文字
- (void) myTextMargin:(int) margin pointsNum:(int) pointsNum scale:(CGFloat) scale
{
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    linePointsTextDic = [[NSMutableDictionary alloc] init];
    for (int i=pointsNum-1; i>=0; i--) {
        // 水位文字
        int n = (int)(sin(i)*15) ;
        NSString *str = [NSString stringWithFormat:@"%d",20+n];
        
        // 储存水位文字 用字典 方便取值
        //        [linePointsText addObject:[NSNumber numberWithInt:n]];
        NSString *akey = [NSString stringWithFormat:@"%d",i];
        //        NSNumber *strWater = [NSNumber numberWithInt:n];
        NSString *strWater = str;
        [linePointsTextDic setObject:strWater forKey:akey];
        // 委托 传值 循环外一次传过去
        //        [self.delegate passLinePointsTextDic:linePointsTextDic];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        // 文字大小 截断 颜色
        NSDictionary *dic = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:10],
                              NSParagraphStyleAttributeName:paragraphStyle,
                              NSForegroundColorAttributeName:[UIColor greenColor]
                              };
        if (scale >0.6 ) {
            [str drawAtPoint:CGPointMake((5+685-i*margin) * scale, 490-sin(i)*50) withAttributes:dic];
        }
        if (scale >0.4 && scale < 0.6) {
            if (i%3) {
                [str drawAtPoint:CGPointMake((5+685-i*margin) * scale, 490-sin(i)*50) withAttributes:dic];
            }
        }
        if (scale >0.2 && scale < 0.4) {
            if (i%2) {
                [str drawAtPoint:CGPointMake((5+685-i*margin) * scale, 490-sin(i)*50) withAttributes:dic];
            }
        }
        if (scale >0.0 && scale < 0.2) {
            if (i%2 && i%3) {
                [str drawAtPoint:CGPointMake((5+685-i*margin) * scale, 490-sin(i)*50) withAttributes:dic];
            }
        }
    }
    CGContextRestoreGState(context);
    // 委托 传值
    [self.delegate passLinePointsTextDic:linePointsTextDic];
}
#pragma mark - 垂直线
- (void)drawLine:(int) x
{
    [self line:x context:context];
}
- (void) line:(int) x context:(CGContextRef)context
{
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
    
    CGContextMoveToPoint(context, x, 50);
    CGContextAddLineToPoint(context, x, 600);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma mark - 绘制文字（时间）垂直线右边
- (void)drawTime:(NSString *) strTime x:(CGFloat) x
{
    [self myContext:context strTime:strTime x:x+10 y:200];
}
// 时间
- (void) myContext:(CGContextRef) context strTime:(NSString *) str x:(CGFloat) x y:(CGFloat) y
{
    CGContextSaveGState(context);
    // 文字
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    // 文字大小 截断 颜色
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:18],
                          NSParagraphStyleAttributeName:paragraphStyle,
                          NSForegroundColorAttributeName:[UIColor orangeColor]
                          };
    [str drawAtPoint:CGPointMake(x, y) withAttributes:dic];
    
    CGContextRestoreGState(context);
}
#pragma mark - 绘制文字（水位）垂直线右边
- (void)drawWaterLevel:(NSString *) strWater x:(CGFloat) x
{
    [self myContext:context strWater:strWater x:x+10 y:150];
}
// 水位
- (void) myContext:(CGContextRef) context strWater:(NSString *) str x:(CGFloat) x y:(CGFloat) y
{
    CGContextSaveGState(context);
    // 文字
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    // 文字大小 截断 颜色
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:18],
                          NSParagraphStyleAttributeName:paragraphStyle,
                          NSForegroundColorAttributeName:[UIColor orangeColor]
                          };
    [str drawAtPoint:CGPointMake(x, y) withAttributes:dic];
    CGContextRestoreGState(context);
}

#pragma mark - 绘制垂线和折线交叉点
- (void) drawPointPositionX:(CGFloat)x PositionY:(CGFloat)y
{
    [self myPointContext:context PostionX:x PostionsY:y];
}
- (void) myPointContext:(CGContextRef) context PostionX:(CGFloat) x PostionsY:(CGFloat) y
{
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    
    // path
    CGMutablePathRef pathM = CGPathCreateMutable(); // 创建path
    
    //    CGContextMoveToPoint(context, x, y);
    CGContextAddArc(context, x, y, 3, 0, M_PI*2, 0);
    
    CGContextAddPath(context, pathM); // 添加path
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}
//#pragma mark - 更新 折线(静态） 文字
//- (void) myUpdateLine2:(CGContextRef) context margin:(int) margin pointsNum:(int) pointsNum scale:(CGFloat) scale
//{
//    CGContextMoveToPoint(context, 5+pointsNum*margin * scale, 475);
//    NSLog(@"===折线===");
//    for (int i=pointsNum-1; i>=0; i--) {
//
//        CGContextAddLineToPoint(context, (5+i*margin) * scale, 500);
//        // 水位文字 m
//        NSString *str = [NSString stringWithFormat:@"%d",20+i];
//
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
//        // 文字大小 截断 颜色
//        if (i % 2 == 1) {
//            continue;
//        }else {
//            NSDictionary *dic = @{
//                                  NSFontAttributeName:[UIFont systemFontOfSize:10],
//                                  NSParagraphStyleAttributeName:paragraphStyle,
//                                  NSForegroundColorAttributeName:[UIColor greenColor]
//                                  };
//            [str drawAtPoint:CGPointMake((5+i*margin) * scale, 500) withAttributes:dic];
//        }
//
//
//    }
//    CGContextStrokePath(context);
//    //    [self setNeedsDisplay]; // 刷新
//}

//#pragma mark - 更新 折线（动态）
//- (void) myUpdateLine2:(CGContextRef) context margin:(int) margin pointsNum:(int) num scale:(CGFloat) scale
//{
//    CGContextMoveToPoint(context, 745, 475);
//    NSLog(@"======");
//    for (int i=num-1; i>=0; i--) {
//        int n = arc4random()%11;
//        CGContextAddLineToPoint(context, (5+i*margin), 500-n*5);
//        // 水位文字 m
//        NSString *str = [NSString stringWithFormat:@"%d",20+n];
//
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
//        // 文字大小 截断 颜色
//        NSDictionary *dic = @{
//                              NSFontAttributeName:[UIFont systemFontOfSize:12],
//                              NSParagraphStyleAttributeName:paragraphStyle,
//                              NSForegroundColorAttributeName:[UIColor greenColor]
//                              };
//        [str drawAtPoint:CGPointMake((5+i*margin), 480-n*5) withAttributes:dic];
//
//    }
//    CGContextStrokePath(context);
////    [self setNeedsDisplay]; // 刷新
//}






#pragma mark - other
- (void) myRect
{
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    //    CGContextAddRect(context, CGRectMake(10, 100, 100, 100));
    //    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    //    CGContextSetLineWidth(context, 20);
    //    CGContextStrokePath(context);
    //    [self setNeedsDisplay];
}
- (void) myArc
{
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextSetLineWidth(context, 5.0);
    //    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    //    CGContextSetRGBFillColor(context, 0, 1, 0, 1);
    //    CGContextSetLineWidth(context, 5.0);
    //    CGContextAddArc(context, 200, 100, 50, 0, M_PI*2, 1);
    //
    ////    CGContextStrokePath(context);
    ////    CGContextFillPath(context);
    //    CGContextDrawPath(context, kCGPathFillStroke);
    
}

///////////////////////////////////////
/**
 // 初始坐标轴 X
 #pragma mark - x轴（折线)
 - (void) myCoordinateX:(CGContextRef) context
 {
 // x
 CGContextMoveToPoint(context,0, 600);
 CGContextAddLineToPoint(context, 800, 600);
 CGContextMoveToPoint(context,795, 595);
 CGContextAddLineToPoint(context, 800, 600);
 CGContextAddLineToPoint(context, 795, 605);
 for (int i=0; i<20; i++) {
 CGContextMoveToPoint(context, 5+i*40, 600);
 CGContextAddLineToPoint(context, 5+i*40, 590);
 }
 // 添加X轴 文字
 for (int i=0; i<20; i++) {
 NSString *str = [NSString stringWithFormat:@"%2.1f",3+i%20/10.0];
 
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
 paragraphStyle.lineBreakMode = NSLineBreakByClipping;
 // 文字大小 截断 颜色
 NSDictionary *dic = @{
 NSFontAttributeName:[UIFont systemFontOfSize:12],
 NSParagraphStyleAttributeName:paragraphStyle,
 NSForegroundColorAttributeName:[UIColor greenColor]
 };
 [str drawAtPoint:CGPointMake(0+i*40, 605) withAttributes:dic];
 }
 // 渲染
 CGContextStrokePath(context);
 
 [self myLine2:context]; // 初始折线
 [self setNeedsDisplay]; // 刷新
 }
 
 // 初始折线
 #pragma mark - 初始折线
 - (void) myLine2:(CGContextRef) context
 {
 NSLog(@"======myLine2");
 CGContextMoveToPoint(context, 785, 475);
 for (int i=18; i>=0; i--) {
 int n = arc4random()%11;
 CGContextAddLineToPoint(context, 5+(i)*40, 500-n*5);
 // 文字
 NSString *str = [NSString stringWithFormat:@"%d",20+n];
 
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
 paragraphStyle.lineBreakMode = NSLineBreakByClipping;
 // 文字大小 截断 颜色
 NSDictionary *dic = @{
 NSFontAttributeName:[UIFont systemFontOfSize:12],
 NSParagraphStyleAttributeName:paragraphStyle,
 NSForegroundColorAttributeName:[UIColor greenColor]
 };
 [str drawAtPoint:CGPointMake(0+(i)*40, 480-n*5) withAttributes:dic];
 
 }
 CGContextStrokePath(context);
 [self setNeedsDisplay]; // 刷新
 }
 
 - (void) myLine
 {
 // 获取上下文
 CGContextRef context = UIGraphicsGetCurrentContext();
 // 设置属性
 CGContextSetLineWidth(context, 10.0);
 CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
 CGContextMoveToPoint(context, 10, 50);
 CGContextAddLineToPoint(context, 100, 50);
 // 渲染
 CGContextStrokePath(context);
 }
 
 - (void) myRect
 {
 CGContextRef context = UIGraphicsGetCurrentContext();
 
 CGContextAddRect(context, CGRectMake(10, 100, 100, 100));
 CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
 
 CGContextStrokePath(context);
 [self setNeedsDisplay];
 }
 
 
 - (void) myArc2
 {
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
 CGContextSetLineWidth(context, 5.0);
 CGContextMoveToPoint(context, 0, 300);
 CGContextAddCurveToPoint(context, 100, 200, 200, 400, 300, 300);
 
 CGContextStrokePath(context);
 }
 
 - (void) myArc3
 {
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
 CGContextSetLineWidth(context, 5.0);
 CGContextMoveToPoint(context, 0, 400);
 CGContextAddQuadCurveToPoint(context, 100, 500, 200, 400);
 
 CGContextStrokePath(context);
 }
 // 坐标轴 Y
 - (void) myCoordinateY
 {
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
 CGContextSetLineWidth(context, 2.0);
 // x
 //    CGContextMoveToPoint(context,50, 600);
 //    CGContextAddLineToPoint(context, 400, 600);
 //    CGContextMoveToPoint(context,395, 595);
 //    CGContextAddLineToPoint(context, 400, 600);
 //    CGContextAddLineToPoint(context, 395, 605);
 //    for (int i=0; i<9; i++) {
 //        CGContextMoveToPoint(context, 50+i*40, 600);
 //        CGContextAddLineToPoint(context, 50+i*40, 590);
 //    }
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
 for (int i=7; i>0; i--) {
 NSString *str = [NSString stringWithFormat:@"%d",120-i*20];
 
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
 paragraphStyle.lineBreakMode = NSLineBreakByClipping;
 // 文字大小 截断 颜色
 NSDictionary *dic = @{
 NSFontAttributeName:[UIFont systemFontOfSize:12],
 NSParagraphStyleAttributeName:paragraphStyle,
 NSForegroundColorAttributeName:[UIColor greenColor]
 };
 if (i<7) {
 [str drawAtPoint:CGPointMake(20, i*100-8) withAttributes:dic];
 }else{
 str = @"水位/m";
 [str drawAtPoint:CGPointMake(5, 50) withAttributes:dic];
 }
 }
 // 添加X轴 文字
 //    for (int i=0; i<8; i++) {
 //        NSString *str = [NSString stringWithFormat:@"%2.1f",3+i/10.0];
 //
 //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
 //        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
 //        // 文字大小 截断 颜色
 //        NSDictionary *dic = @{
 //                              NSFontAttributeName:[UIFont systemFontOfSize:12],
 //                              NSParagraphStyleAttributeName:paragraphStyle,
 //                              NSForegroundColorAttributeName:[UIColor greenColor]
 //                              };
 //        [str drawAtPoint:CGPointMake(80+i*40, 605) withAttributes:dic];
 //    }
 //    // 渲染
 //    CGContextStrokePath(context);
 //
 //    [self myLine2:context];
 [self setNeedsDisplay]; // 刷新
 }
 
 */



@end
