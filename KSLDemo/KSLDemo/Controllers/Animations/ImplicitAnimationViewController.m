//
//  ImplicitAnimationViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/10.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  隐式动画

#import "ImplicitAnimationViewController.h"
#import "UIColor+KSLExtension.h"

/**
 *  每一个uiview都默认关联着一个CALayer，我们成这个layer为root layer
 所有的非root layer都存在默认的隐私动画，隐式动画默认为1/4秒。
 如果关闭默认的动画效果：可以通过动画的事务方法实现。
 */

@interface ImplicitAnimationViewController ()

@property (nonatomic, weak)CALayer *greenLayer;
@property (nonatomic, weak)UIImageView *redView;

@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"隐式动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupSubviews];
}

- (void)setupSubviews
{
    //UIView中的center就是layer中的position
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 100, 100);
//    layer.position = CGPointMake(100, 64 + 100);
//    layer.anchorPoint = CGPointMake(0, 0);
//    layer.backgroundColor = [UIColor greenColor].CGColor;
//    self.greenLayer = layer;
//    [self.view.layer addSublayer:layer];
    
    UIImageView *aView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart"]];
    [aView setBackgroundColor:[UIColor clearColor]];
    aView.center = CGPointMake(100 + 10 + 100, 64 + 100);
    //aView.bounds = CGRectMake(0, 0, 100, 100);
    //动画是绕着anchorPoint做的
    //aView.layer.anchorPoint = CGPointMake(0, 0);
    [self.view addSubview:aView];
    self.redView = aView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self implicitAnimation];
    [self heartbeat];
}

- (void)implicitAnimation
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

- (void)heartbeat
{
    //创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置属性
    anim.keyPath = @"transform.scale";
    //设置属性值.
    anim.toValue = @0;
    
    //设置动画的执行次数
    anim.repeatCount = MAXFLOAT;
    
    //设置动画的执行时长
    anim.duration = 0.5;
    
    //自动反转
    anim.autoreverses = YES;
    
    //添加动画
    [self.redView.layer addAnimation:anim forKey:nil];
    

}

- (CGFloat)randomValue
{
    return arc4random_uniform(200) + 50;
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
