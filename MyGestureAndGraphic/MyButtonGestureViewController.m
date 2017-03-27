//
//  MyButtonGestureViewController.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/26.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#import "MyButtonGestureViewController.h"
#import "myButton.h"
#define screenH [UIScreen mainScreen].bounds.size.height
typedef enum GestureOptions {
    tap = 0,
    longPress,
    swipe,
    pan,
    screenPan,
    pinch,
    rotation,
} GestureOptions;
GestureOptions myBtGestureOption;
@interface MyButtonGestureViewController ()
@property (nonatomic,strong) UILabel *yellowLabel;
@property (nonatomic,strong) UILabel *hiddenLabel;

@end

@implementation MyButtonGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    
    [self initLabelState]; // labels
    
    [self initButtonsState]; // buttons
}
- (void) goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 设置label初始状态
- (void) initLabelState {
    // 黄色label
    _yellowLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 280, 398, 350)];
    _yellowLabel.backgroundColor = [UIColor yellowColor];
    _yellowLabel.textAlignment = NSTextAlignmentCenter;
     [self.yellowLabel setUserInteractionEnabled:YES]; // 启用“手势label”
    [self.view addSubview:_yellowLabel];
    
    // 隐藏label
    _hiddenLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 210, 170, 86)];
    _hiddenLabel.backgroundColor = [UIColor lightGrayColor];
    _hiddenLabel.textAlignment = NSTextAlignmentCenter;
//     [self.hiddenLabel setUserInteractionEnabled:YES]; // 启用“手势label”
    _hiddenLabel.alpha = 0.0;
    [self.view addSubview:_hiddenLabel];

}
#pragma mark - 设置按钮初始状态
- (void) initButtonsState
{
    // 按钮
    myButton *tapBt = [[myButton alloc] initWithFrame:CGRectMake(8, 210, 50, 50)];
    [tapBt setTitle:@"点击" forState:UIControlStateNormal];
    myButton *longPressBt = [[myButton alloc] initWithFrame:CGRectMake(66, 150, 50, 50)];
    [longPressBt setTitle:@"长按" forState:UIControlStateNormal];
    myButton *swipBt = [[myButton alloc] initWithFrame:CGRectMake(120, 90, 50, 50)];
    [swipBt setTitle:@"轻扫" forState:UIControlStateNormal];
    myButton *panBt = [[myButton alloc] initWithFrame:CGRectMake(182, 30, 50, 50)];
    [panBt setTitle:@"滑动" forState:UIControlStateNormal];
    myButton *screenPanBt = [[myButton alloc] initWithFrame:CGRectMake(240, 90, 50, 50)];
    [screenPanBt setTitle:@"边缘" forState:UIControlStateNormal];
    myButton *pinchBt = [[myButton alloc] initWithFrame:CGRectMake(298, 150, 50, 50)];
    [pinchBt setTitle:@"缩放" forState:UIControlStateNormal];
    myButton *rotationBt = [[myButton alloc] initWithFrame:CGRectMake(356, 210, 50, 50)];
    [rotationBt setTitle:@"旋转" forState:UIControlStateNormal];
    [self.view addSubview:tapBt];
    [self.view addSubview:longPressBt];
    [self.view addSubview:swipBt];
    [self.view addSubview:panBt];
    [self.view addSubview:screenPanBt];
    [self.view addSubview:pinchBt];
    [self.view addSubview:rotationBt];

    for (myButton *bt in self.view.subviews) {
        if ([bt isKindOfClass:[myButton class]]) {
            [bt addTarget:self action:@selector(changeBtLabel:) forControlEvents:UIControlEventTouchUpInside];// 事件
        }
    }
    // 返回按钮
    UIButton *backBt = [[UIButton alloc] initWithFrame:CGRectMake(138, 654, 138, 50)];
    [backBt setTitle:@"返回" forState:UIControlStateNormal];
    backBt.backgroundColor = [UIColor redColor];
    [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [backBt setFont:[UIFont systemFontOfSize:36.0]]; // 过期
    //    [backBt.titleLabel setFont:[UIFont systemFontOfSize:36.0]];
    backBt.titleLabel.font = [UIFont systemFontOfSize:36.0];
    [backBt addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
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
    for (UIButton *myBt in self.view.subviews) {
        if ([myBt isKindOfClass:[myButton class]]) {
                [myBt setUserInteractionEnabled:NO]; // 禁用”返回“外的按钮
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
    switch (myBtGestureOption) {
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
        myBtGestureOption = tap;
    } else if ([[bt currentTitle] isEqualToString:@"长按"]) {
        myBtGestureOption = longPress;
    }else if ([[bt currentTitle] isEqualToString:@"轻扫"]) {
        myBtGestureOption = swipe;
    }else if ([[bt currentTitle] isEqualToString:@"滑动"]) {
        myBtGestureOption = pan;
    }else if ([[bt currentTitle] isEqualToString:@"边缘"]) {
        myBtGestureOption = screenPan;
    }else if ([[bt currentTitle] isEqualToString:@"缩放"]) {
        myBtGestureOption = pinch;
    }else if ([[bt currentTitle] isEqualToString:@"旋转"]) {
        myBtGestureOption = rotation;
    }
    
    self.hiddenLabel.text = @""; // 清空上次text
    NSString *hiddenLabelText = [NSString stringWithFormat:@"%@手势已经触发",[bt currentTitle]];
    self.hiddenLabel.text = hiddenLabelText;
    
    if (myBtGestureOption == screenPan) {
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
        if(myBtGestureOption == tap || myBtGestureOption == swipe){
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
        
        if (myBtGestureOption == screenPan) {
            [self.view removeGestureRecognizer:gesture];
            NSLog(@"移除screenPan手势成功");
        }else{
            [self.yellowLabel removeGestureRecognizer:gesture];
            NSLog(@"移除手势成功");
        }
        
        for (UIButton *bt in self.view.subviews)
        {
            if ([bt isKindOfClass:[myButton class]])
            {
                bt.backgroundColor = [UIColor colorWithRed:237.0/255 green:143.0/255 blue:73/255 alpha:1.0];
                [bt setUserInteractionEnabled:YES]; // 启用”返回“外的按钮
            }
        }
        [self.yellowLabel setUserInteractionEnabled:YES]; // 启用“手势label”
    }];
}


@end
