//
//  Quartz2d.h
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/25.
//  Copyright © 2017年 邹前立. All rights reserved.
//

/**
 * X轴的绘制
 * 折线的绘制
 *
 */
#import <UIKit/UIKit.h>

@protocol XxxxxDelegate <NSObject>
// 传递x轴X坐标 和 折线拐点坐标 x坐标对应的时间文字 折线拐点水位文字 (推荐使用字典）
// X轴X坐标和折线X坐标相同
- (void) passXPoints:(NSMutableArray *) xPoints; // 传递x轴X坐标
- (void) passLinePoints:(NSMutableArray *) linePoints;// 折线拐点坐标
- (void) passLinePointsDic:(NSMutableDictionary *) linePointsDic;// 折线 拐点拐点 坐标
- (void) passXPointsText:(NSMutableArray *) xPointsText;// x坐标对应的时间文字
- (void) passXPointsTextDic:(NSMutableDictionary *) xPointsTextDic;// x坐标对应的时间文字
- (void) passLinePointsText:(NSMutableArray *) linePointsText;// 折线拐点水位文字
- (void) passLinePointsTextDic:(NSMutableDictionary *) linePointsTextDic;// 折线拐点水位文字

@end

@interface Xxxxx : UIView
// 缩放比例
@property (nonatomic,assign) float scale;

@property (nonatomic,weak) id<XxxxxDelegate> delegate;
// X坐标
- (void)drawX;
- (void) myUpdateCoordinate:(CGContextRef)context margin:(int) margin pointsNum:(int) pointsNum;


// 折线
- (void)drawLine2;
- (void) myUpdateLine2:(CGContextRef) context margin:(int) margin pointsNum:(int) pointsNum;

// 直线
- (void) drawLine:(int) x;
- (void) line:(int) x context:(CGContextRef)context;

// 文字
- (void)drawTime:(NSString *) strTime x:(CGFloat) x; // 时间
- (void)drawWaterLevel:(NSString *) strWater x:(CGFloat) x; // 水位

// 折线与垂直线的交叉点/圆
- (void) drawPointPositionX:(CGFloat) x PositionY:(CGFloat) y;

@end
