//
//  myGestureViewController.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/24.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#import "MyGestureViewController.h"
#define screenH [UIScreen mainScreen].bounds.size.height
typedef enum GestureOptions {
    tap = 0, // 整形值 可以配合case使用 oc的case还是整型值
    longPress,
    swipe,
    pan,
    screenPan,
    pinch,
    rotation,
} GestureOptions;
@interface MyGestureViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tapBt;
@property (weak, nonatomic) IBOutlet UIButton *longPressBt;
@property (weak, nonatomic) IBOutlet UIButton *swipBt;
@property (weak, nonatomic) IBOutlet UIButton *panBt;
@property (weak, nonatomic) IBOutlet UIButton *screenPanBt;
@property (weak, nonatomic) IBOutlet UIButton *pinchBt;
@property (weak, nonatomic) IBOutlet UIButton *rotationBt;
@property (weak, nonatomic) IBOutlet UILabel  *yellowLabel;
@property (weak, nonatomic) IBOutlet UILabel  *hiddenLabel;

- (IBAction)goBack:(UIButton *)sender;

@end

@implementation MyGestureViewController
GestureOptions gestureOption;

UIView *gestureView; // xib
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 加载xib文件
    gestureView = [[[NSBundle mainBundle] loadNibNamed:@"MyGestureViewController" owner:self options:nil] firstObject];
    
    [self initButtonsState];
}

#pragma mark - 设置按钮初始状态
- (void) initButtonsState
{
    for (UIButton *bt in gestureView.subviews) {
        if ([bt isKindOfClass:[UIButton class]]) {
            NSString *currentTitle = [bt currentTitle];
            if ([currentTitle isEqualToString:@"返回"]) {
                continue;
            }else{
                bt.layer.cornerRadius = 25.0;
                bt.backgroundColor = [UIColor colorWithRed:237.0/255 green:143.0/255 blue:73/255 alpha:1.0]; // 背景
                [bt addTarget:self action:@selector(changeBtLabel:) forControlEvents:UIControlEventTouchUpInside];// 事件
            }
        }
    }
    
}
#pragma mark - 点击按钮 改变按钮颜色 label.text
- (void) changeBtLabel:(UIButton *) bt
{
    /**考虑
     // 每次点击其他按钮前移除手势，不禁用按钮
     if (gestureOption == screenPan) {
     [self.view removeGestureRecognizer:gesture];
     NSLog(@"移除screenPan手势成功");
     }else{
     [self.yellowLabel removeGestureRecognizer:gesture];
     NSLog(@"移除手势成功");
     }*/
    
    bt.backgroundColor = [UIColor purpleColor];
    NSString *title = [bt currentTitle];
    self.yellowLabel.text = title;
    for (UIButton *bt in gestureView.subviews) {
        if ([bt isKindOfClass:[UIButton class]]) {
            if ([[bt currentTitle] isEqualToString:@"返回"]) {
                continue;
            }else{
                [bt setUserInteractionEnabled:NO]; // 禁用”返回“外的按钮
            }
        }
    }
    // 测试单个手势
    /**    UIGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
     [self.view addGestureRecognizer:g];
     */
    // 创建 添加手势
    [self addGestureWithBt:bt];
}

#pragma mark - 创建手势
// 点击按钮时候 创建手势
- (id) createGestureWithBt:(UIButton *) bt{
    id gesture = nil;
    switch (gestureOption) {
        case tap:{
            gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break;}
        case longPress:{
            gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break;}
        case swipe:{
            gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break;}
        case pan:{
            gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break; }
        case screenPan:{
            gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break; }
        case pinch:{
            gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break; }
        case rotation:{
            gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAnimation:)];
            return gesture;
            break;}
        default:
            break;
    }
    return gesture;
}
#pragma mark - 添加手势
- (void)addGestureWithBt:(UIButton *)bt
{
    if ([[bt currentTitle] isEqualToString:@"点击"]) {
        gestureOption = tap;
    } else if ([[bt currentTitle] isEqualToString:@"长按"]) {
        gestureOption = longPress;
    }else if ([[bt currentTitle] isEqualToString:@"轻扫"]) {
        gestureOption = swipe;
    }else if ([[bt currentTitle] isEqualToString:@"滑动"]) {
        gestureOption = pan;
    }else if ([[bt currentTitle] isEqualToString:@"边缘"]) {
        gestureOption = screenPan;
    }else if ([[bt currentTitle] isEqualToString:@"缩放"]) {
        gestureOption = pinch;
    }else if ([[bt currentTitle] isEqualToString:@"旋转"]) {
        gestureOption = rotation;
    }
    
    self.hiddenLabel.text = @""; // 清空上次text
    NSString *hiddenLabelText = [NSString stringWithFormat:@"%@手势已经触发",[bt currentTitle]];
    self.hiddenLabel.text = hiddenLabelText;
    
    if (gestureOption == screenPan) {
        UIScreenEdgePanGestureRecognizer * gesture = [self createGestureWithBt:bt]; // 创建手势
        gesture.edges = UIRectEdgeRight;
        [self.view addGestureRecognizer:gesture]; // 添加给view
    }else{
        UIGestureRecognizer *gesture = [self createGestureWithBt:bt]; // 创建手势
        [self.yellowLabel addGestureRecognizer:gesture]; // 添加给label
    }
}

#pragma mark - 根据手势状态 执行动画
- (void) gestureAnimation:(UIGestureRecognizer *) gesture
{
    
    NSLog(@"%@",gesture); // 跟踪手势类型
    self.hiddenLabel.alpha = 0.55;
    [self.yellowLabel setUserInteractionEnabled:NO]; // 禁用 "手势label"
    //    [self myAnimateWithGesture:gesture];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if(gestureOption == tap || gestureOption == swipe){
            [self myAnimateWithGesture:gesture];
        }
    }else {
        if (gesture.state == UIGestureRecognizerStateBegan) {
            [self myAnimateWithGesture:gesture];
        }
    }
}
#pragma mark - 手势动画效果
- (void) myAnimateWithGesture:(UIGestureRecognizer *) gesture
{
    // 获取hiddenLabel frame
    CGFloat x = self.hiddenLabel.frame.origin.x;
    CGFloat y = self.hiddenLabel.frame.origin.y;
    CGFloat w = self.hiddenLabel.frame.size.width;
    CGFloat h = self.hiddenLabel.frame.size.height;
    [UIView animateWithDuration:3.0 animations:^{
        self.hiddenLabel.frame = CGRectMake(x, screenH, w, h); // 移到屏幕外即可
    } completion:^(BOOL finished) {
        self.hiddenLabel.frame = CGRectMake(x, y, w, h);
        self.hiddenLabel.alpha = 0.0;
        
        if (gestureOption == screenPan) {
            [self.view removeGestureRecognizer:gesture];
            NSLog(@"移除screenPan手势成功");
        }else{
            [self.yellowLabel removeGestureRecognizer:gesture];
            NSLog(@"移除手势成功");
        }
        
        for (UIButton *bt in gestureView.subviews)
        {
            if ([bt isKindOfClass:[UIButton class]])
            {
                if ([[bt currentTitle] isEqualToString:@"返回"]) {
                    continue;
                }else{
                    bt.backgroundColor = [UIColor colorWithRed:237.0/255 green:143.0/255 blue:73/255 alpha:1.0];
                    [bt setUserInteractionEnabled:YES]; // 启用”返回“外的按钮
                }
            }
        }
        [self.yellowLabel setUserInteractionEnabled:YES]; // 启用“手势label”
    }];
}

#pragma mark - 返回
- (IBAction)goBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
