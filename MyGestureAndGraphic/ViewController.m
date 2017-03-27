//
//  ViewController.m
//  MyGesturesAndGraphics
//
//  Created by 邹前立 on 2017/3/24.
//  Copyright © 2017年 邹前立. All rights reserved.
//

#import "ViewController.h"
#import "MyGestureViewController.h"
#import "MyGraphicViewController.h"
#import "MyButtonGestureViewController.h"

@interface ViewController ()
- (IBAction)alertItem:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 点击屏幕
- (IBAction)alertItem:(id)sender {
    UIAlertView *alertItem = [[UIAlertView alloc] initWithTitle:@"你想干嘛" message:@"选一个" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"手势myBt",@"手势xib",@"绘图", nil];
    [alertItem show];
}

#pragma mark - UIAlertView delegate method 选择进入的控制器
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        MyButtonGestureViewController *myBtGestureVC = [[MyButtonGestureViewController alloc] init];
        [self presentViewController:myBtGestureVC animated:YES completion:nil];
    }
    else if (buttonIndex == 2) {
        MyGestureViewController *myGestureVC = [[MyGestureViewController alloc] init];
        [self presentViewController:myGestureVC animated:YES completion:nil];
    }
    else if (buttonIndex == 3) {
        MyGraphicViewController *myGraphicVC = [[MyGraphicViewController alloc] init];
        [self presentViewController:myGraphicVC animated:YES completion:nil];
    }
    else {
        return;
    }
}

@end
