//
//  ImplicitAnimationViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/10.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  隐式动画

#import "ImplicitAnimationViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "UIColor+KSLExtension.h"

@interface ImplicitAnimationViewController ()

@property (nonatomic, weak)CALayer *greenLayer;
@property (nonatomic, weak)UIView *redView;

@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"隐式动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupSubviews];
    
    [self setupNextViewButton];
}

- (void)setupSubviews
{
    //UIView中的center就是layer中的position
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 64 + 100);
    layer.anchorPoint = CGPointMake(0, 0);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    self.greenLayer = layer;
    [self.view.layer addSublayer:layer];
    
    UIView *aView = [[UIView alloc] init];
    [aView setBackgroundColor:[UIColor redColor]];
    aView.center = CGPointMake(100 + 10 + 100, 64 + 100);
    aView.bounds = CGRectMake(0, 0, 100, 100);
    aView.layer.anchorPoint = CGPointMake(0, 0);
    [self.view addSubview:aView];
    self.redView = aView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.redView.center = CGPointMake(100, 64 + 100);
    self.redView.layer.anchorPoint = CGPointMake(0, 0);
    
    [CATransaction begin];
    //可以设置有没有动画
    //[CATransaction setDisableActions:YES];
    //可以设置事务动画的时长
    [CATransaction setAnimationDuration:2];
    self.greenLayer.bounds = CGRectMake(0, 0, [self randomValue], [self randomValue]);
    self.greenLayer.position = CGPointMake([self randomValue], [self randomValue]);
    self.greenLayer.backgroundColor = [UIColor ksl_randomColor].CGColor;
    [CATransaction commit];
}

- (CGFloat)randomValue
{
    return arc4random_uniform(200) + 50;
}

- (void)setupNextViewButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showNextView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
}

- (void)showNextView:(id)sender
{
    KeyFrameAnimationViewController *animationView = [[KeyFrameAnimationViewController alloc] init];
    [self.navigationController pushViewController:animationView animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"[--dealloc: %@--]",NSStringFromClass(self.class));
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
