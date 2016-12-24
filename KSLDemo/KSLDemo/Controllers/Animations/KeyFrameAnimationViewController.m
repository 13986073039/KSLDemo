//
//  KeyFrameAnimationViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/10.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"
#import "WheelsViewController.h"

@interface KeyFrameAnimationViewController ()

@property (nonatomic, weak)UIImageView *imageView;

@end

@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"桢动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupSubviews];
    [self setupNextViewButton];
}

- (void)setupSubviews
{
    UIImage *aImage = [UIImage imageNamed:@"caipiao163"];
    UIImageView *aimageView = [[UIImageView alloc] initWithImage:aImage];
    aimageView.center = CGPointMake((KSLSCREENW - aImage.size.width) * 0.5, (KSLSCREENH - aImage.size.height) * 0.5);
    [self.view addSubview:aimageView];
    
    self.imageView = aimageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self pathView];
    //[self trembleView];

}

- (void)pathView
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 300, 400)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, 0)];
    [path2 addLineToPoint:CGPointMake(KSLSCREENW, KSLSCREENH)];
    
    animation.path = path2.CGPath;
    animation.repeatCount = MAXFLOAT;
    animation.duration = 4;
    animation.autoreverses = YES;
    [self.imageView.layer addAnimation:animation forKey:nil];
}

- (void)trembleView
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(angleToRad(-5)),@(angleToRad(5)),@(angleToRad(-5))];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.25;
    [self.imageView.layer addAnimation:animation forKey:nil];
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
    WheelsViewController *animationView = [[WheelsViewController alloc] init];
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
