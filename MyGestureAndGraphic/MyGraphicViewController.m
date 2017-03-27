//
//  MyGraphicViewViewController.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/24.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#import "MyGraphicViewController.h"
#import "Yyyyy.h"
#import "Xxxxx.h"
@interface MyGraphicViewController ()
@property (weak, nonatomic) IBOutlet Yyyyy *waterViewLeft;
@property (weak, nonatomic) IBOutlet Xxxxx *waterViewRight;

- (IBAction)goBack;

@end

@implementation MyGraphicViewController
NSMutableArray *LinePoints;             // 接收折线 X坐标
NSMutableDictionary *LinePointsDic;     // 接收折线 拐点 Y坐标
NSMutableArray *XPoints;                // 接收X轴  X坐标
NSMutableArray *LinePointsText;         // 接收折线 文字
NSMutableDictionary *LinePointsTextDic; // 接收折线 文字
NSMutableArray *XPointsText;            // 接收X轴  文字
NSMutableDictionary *XPointsTextDic;    // 接收X轴  文字 方便根据key取值
CGPoint curPoint;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    XPoints = [[NSMutableArray alloc] init];
    XPointsText = [[NSMutableArray alloc] init];
    LinePoints = [[NSMutableArray alloc] init];
    LinePointsText = [[NSMutableArray alloc] init];
    XPointsTextDic = [[NSMutableDictionary alloc] init];
    LinePointsTextDic = [[NSMutableDictionary alloc] init];
    
    _waterViewRight.scale = 1.0;
    if (_waterViewRight.scale == 1.0) {
        //        for (NSNumber *num in xPoints) {
        //            NSLog(@"X轴的X坐标%f",num.floatValue);
        //        }
        [_waterViewRight setNeedsDisplay]; // 初始化 第一次显示 或 scal=1.0
    }
    // 手势
    UIGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchFun:)];
    [_waterViewRight addGestureRecognizer:pinchGesture];
    UIGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFun:)];
    [_waterViewRight addGestureRecognizer:longPressGesture];

    
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 长按手势
- (void) longPressFun:(UILongPressGestureRecognizer *) gesture
{
    //    self.waterViewRight.frame = CGRectMake(55, 0, 800, 736);
    //    _waterViewRight.scale = 1.0;
    _waterViewRight.delegate = self;
    // 当前点
    curPoint = [gesture locationInView:_waterViewRight];
    //    NSLog(@"curX=%f,curY=%f]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]",curPoint.x,curPoint.y);
    // 委托 传值
    //    [_waterViewRight drawX ]; // X轴
    //    [_waterViewRight drawLine2]; // 折线
    [_waterViewRight setNeedsDisplay]; // 刷新
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        curPoint.x = -1000.0;
        [_waterViewRight setNeedsDisplay];
    }
    
}
#pragma mark - 捏合手势
- (void) pinchFun:(UIPinchGestureRecognizer *) gesture
{
    CGFloat width = 800.0;
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //        NSLog(@"I'am changed=========%f=============",_waterViewRight.scale);
        _waterViewRight.scale = gesture.scale; // 设置控件比例
        
        // 设置控件宽度--比例变化了
        self.waterViewRight.frame = CGRectMake(55, 0, width*(gesture.scale), 736);
        
        //        if (waterViewWidth > width * 0.1 && waterViewWidth <= width * 1.0) {
        if (gesture.scale <= 0.8 && gesture.scale > 0.79) {
            [_waterViewRight setNeedsDisplay]; // 刷新
        }
        if (gesture.scale <= 0.6 && gesture.scale > 0.59) {
            [_waterViewRight setNeedsDisplay]; // 刷新
        }
        if (gesture.scale <= 0.4 && gesture.scale > 0.39) {
            [_waterViewRight setNeedsDisplay]; // 刷新
        }
        if (gesture.scale <= 0.2 && gesture.scale > 0.19) {
            [_waterViewRight setNeedsDisplay]; // 刷新
        }
        
        //        }
    }
    // 手势完毕 还原
    if (gesture.state == UIGestureRecognizerStateEnded) {
        curPoint.x = -1000.0;
        self.waterViewRight.frame = CGRectMake(55, 0, 800, 736);
        _waterViewRight.scale = 1.0;
        [_waterViewRight setNeedsDisplay];
    }
}
#pragma mark - 接收X轴X坐标
// 传值X坐标
- (void)passXPoints:(NSMutableArray *) xPoints
{
    XPoints = [NSMutableArray arrayWithArray:xPoints];
    //    for (NSNumber *num in xPoints) {
    ////      NSLog(@"接收xPoints xxxxxxxxxX坐标%d",num.intValue);
    //        [XPoints addObject:num];
    //    }
    for (NSNumber *num in XPoints) {  // 判断次数太多了， 能不能减少判断次数 if switch？
        //      NSLog(@"输出XPoints接收的xxxxxxxxxX坐标%f",num.floatValue);
        
        // 当前点 与其中一个点的距离 的绝对值 小于 某个值 绘制直线
        int distance = abs(num.intValue - (int)curPoint.x);
        
        if ( distance < 20 ) { // distance大 输出语句多， for循环多 延迟严重
            //            NSLog(@"num [[[[[[[[[[[[[[[[[[[[[[[[[[ %@",num);
            [_waterViewRight drawLine:num.intValue]; // 绘制垂直线
            //
            //            // 准备取出 时间文字 折线文字
            int idx = (int)[XPoints indexOfObject:num]; // 取出索引
            //            NSLog(@"idx -------------------- %d",idx);
            NSString *akey = [NSString stringWithFormat:@"%d",idx]; // 得到key 和折线key相同吗？存储顺序不同
            //
            //            // 根据key取值--字符串--X轴时间文字
            NSString *str = [XPointsTextDic objectForKey:akey];
            //            NSString *str = [XPointsText objectAtIndex:idx];
            //            if (str == nil) {
            //                continue; // 从数组循环取值 不跳过 ， 会有（null）重叠
            //            }
            NSString *strTime = [NSString stringWithFormat:@"时间：%@",str]; // 根据字典取值好取一些 要改
            //
            idx = abs(idx - 18 + 1);
            akey = [NSString stringWithFormat:@"%d",idx];
            
            //            // 根据key取值--字符串--折线水位文字
            str = [LinePointsTextDic objectForKey:akey];
            //            if (str == nil) {
            //                continue; // 从数组循环取值 不跳过 ， 会有（null）重叠
            //            }
            NSString *strWater = [NSString stringWithFormat:@"水位：%@m",str];
            //
            //
            [_waterViewRight drawTime:strTime x:num.intValue+10]; // 绘制时间文字
            //
            [_waterViewRight drawWaterLevel:strWater x:num.intValue+10]; // 绘制水位文字
            
            //TODO 绘制 折线与垂直线的交叉点
            //            // 取出 点对象
            //            NSValue *crossPointObj = [LinePointsDic objectForKey:akey];
            //            //
            //            CGPoint crossPoint = [crossPointObj CGPointValue];
            CGFloat positionX = num.floatValue;
            CGFloat positionY = [[LinePointsDic objectForKey:akey] floatValue];
            
            
            [_waterViewRight drawPointPositionX:positionX PositionY:positionY]; // 绘制点
            [_waterViewRight setNeedsDisplay];
            
            break; // 绘制一次就行
        }
        //        if(curPoint.x <= 0.0) {
        //            [_waterViewRight setNeedsDisplay];
        //        }
    }
    
    
}
#pragma mark - 接收折线 拐点（X坐标 Y坐标）绘制交叉点 还用字典
- (void)passLinePointsDic:(NSMutableDictionary *)linePointsDic
{
    LinePointsDic = [NSMutableDictionary dictionaryWithDictionary:linePointsDic];
}
#pragma mark - 接收折线 拐点（X坐标 Y坐标）绘制交叉点 还用字典吗？数组（存储点）
// 传值折线坐标
- (void) passLinePoints:(NSMutableArray *) linePoints
{
    LinePoints = [NSMutableArray arrayWithArray:LinePoints]; // 一行搞定
    
    //    LinePoints = [[NSMutableArray alloc] init];
    //    for (NSNumber *num in linePoints) {
    //        if (num) {
    ////            NSLog(@"接收折线linePoints xxxxxxxxxX坐标%d",num.intValue);
    //            [LinePoints addObject:num];
    ////            for (NSNumber *num in LinePoints) {
    ////                NSLog(@"输出折线 LinePoints接收的xxxxxxxxxX坐标%f",num.floatValue);
    ////            }
    //
    //
    //        }
    //    }
}
#pragma mark - 接收X轴文字
// 传值X轴时间文字 arr
#pragma mark 使用 array 接收X轴文字
- (void) passXPointsText:(NSMutableArray *) xPointsText
{
    //    XPointsText = [NSMutableArray arrayWithArray:xPointsText];
    for (NSString *str in xPointsText) {
        //        NSLog(@"xText%@",str);
        [XPointsText addObject:str]; // 接收
    }
}
// 传值X轴时间文字 dic
#pragma mark 使用 dic 接收X轴文字 方便取值
- (void) passXPointsTextDic:(NSMutableDictionary *) xPointsTextDic
{
    XPointsTextDic = [NSMutableDictionary dictionaryWithDictionary:xPointsTextDic];
    //    NSString *text1 = [xPointsTextDic objectForKey:@"1"];
    //    NSLog(@"text1-------%@",text1);
    
    //    for (int i=0; i<18; i++) {
    //        NSString *text = [XPointsTextDic objectForKey:[NSString stringWithFormat:@"%d",i]];
    //         NSLog(@"text-------%@",text);
    //    }
}
#pragma mark - 接收折线文字
#pragma mark 数组 接收折线文字
- (void) passLinePointsText:(NSMutableArray *) linePointsText
{
    LinePointsText = [NSMutableArray arrayWithArray:linePointsText];
}
#pragma mark 字典 接收折线文字 方便取值
- (void)passLinePointsTextDic:(NSMutableDictionary *)linePointsTextDic
{
    LinePointsTextDic = [NSMutableDictionary dictionaryWithDictionary:linePointsTextDic];
}
@end

