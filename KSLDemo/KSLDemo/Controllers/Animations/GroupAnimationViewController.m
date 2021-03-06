//
//  GroupAnimationViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/12/11.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  动画组

#import "GroupAnimationViewController.h"
#import "WheelsViewController.h"
#import "KSLWheelView.h"
#import "KSLWheelButton.h"

#import "KSLWeiboMenuViewController.h"

@interface GroupAnimationViewController ()

@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, weak)UIView *bgView;
@property (nonatomic, weak)KSLWheelView *wheelView;
@property (nonatomic, weak)KSLWheelButton *wheelButton;
//@property (nonatomic, strong)KSLWheelButton *wheelButton;

@end

@implementation GroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"组动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self testAddSubview];
    
    [self setupSubviews];
    [self setupNextViewButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"self.wheelButton = %@",self.wheelButton);
}

//如果被添加的View采用修饰符weak，则view被从父视图中移除时会被释放
//如果被添加的View采用修饰符strong，则view被从父视图中移除时不会被释放，父视图被释放时才被释放
- (void)testAddSubview
{
    KSLWheelView *aView = [[KSLWheelView alloc] init];
    [self.view addSubview:aView];
    self.wheelView = aView;
    
    KSLWheelButton *aButton = [[KSLWheelButton alloc] init];
    [self.wheelView addSubview:aButton];
    self.wheelButton = aButton;

}

- (void)setupSubviews
{
    UIView *aView = [[UIView alloc] init];
    [aView setBackgroundColor:[UIColor redColor]];
    
    UIImage *image = [UIImage imageNamed:@"clockIcon"];
    UIImageView *aImageView = [[UIImageView alloc] initWithImage:image];
    
    aView.frame = CGRectMake(-image.size.width, KSLSCREENH + image.size.height, image.size.width, image.size.height);
    aImageView.frame = CGRectMake(-image.size.width, KSLSCREENH + image.size.height, image.size.width, image.size.height);
    
    [self.view addSubview:aView];
    [self.view addSubview:aImageView];
    
    self.bgView = aView;
    self.imageView = aImageView;

}

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    //wheelView被释放后，wheelView上的子视图也被释放
    [self.wheelView removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"self.wheelButton = %@",self.wheelButton);
    });
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    //缩放
    CABasicAnimation *scaleAnim = [CABasicAnimation animation];
    //设置属性
    scaleAnim.keyPath = @"transform.scale";
    scaleAnim.toValue = @0.5;
    
    UIImage *aImage = [UIImage imageNamed:@"clockIcon"];
    
    //平移
    CABasicAnimation *Anim = [CABasicAnimation animation];
    //设置属性
    Anim.keyPath = @"position";
    //Anim.toValue = @(KSLSCREENW + aImage.size.width/4.0);
    Anim.toValue = [NSValue valueWithCGPoint:CGPointMake(KSLSCREENW + aImage.size.width/4.0, -aImage.size.height/4.0)];
    
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    
    group.animations = @[scaleAnim,Anim,animation];
    
    group.duration = 8;
    group.removedOnCompletion = NO;
    group.fillMode  = kCAFillModeForwards;
    group.autoreverses = YES;
    group.repeatCount = MAXFLOAT;
    //添加动画
    [self.imageView.layer addAnimation:group forKey:nil];
    
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.animations = @[scaleAnim,Anim];
    group2.duration = 8;
    group2.removedOnCompletion = NO;
    group2.fillMode  = kCAFillModeForwards;
    group2.autoreverses = YES;
    group2.repeatCount = MAXFLOAT;
    [self.bgView.layer addAnimation:group2 forKey:nil];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
