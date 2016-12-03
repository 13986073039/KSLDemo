//
//  FourthViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/11/27.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "FourthViewController.h"
#import "Quartz2dView.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FourthView";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    
}

- (void)setupSubviews
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    Quartz2dView *view = [[Quartz2dView alloc] initWithFrame:CGRectMake(0, 64 + 10, rect.size.width, rect.size.height - 64 -10)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    [view setNeedsDisplay];
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
