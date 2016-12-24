//
//  WheelsViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/23.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "WheelsViewController.h"
#import "KSLWheelView.h"

@interface WheelsViewController ()

@end

@implementation WheelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"转盘";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupSubviews];
}

- (void)setupSubviews
{
    KSLWheelView *view = [[KSLWheelView alloc] initWithFrame:CGRectMake((KSLSCREENW - 286)/2.0, 94, 286, 286)];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
