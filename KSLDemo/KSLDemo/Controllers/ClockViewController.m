//
//  ClockViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/10.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "ClockViewController.h"
#import "ImplicitAnimationViewController.h"

#define angleToRad(angle) ((angle)/180.0 * M_PI)

//秒针每一秒旋转的度数
const CGFloat perSecondA = 6;

//分针每一分旋转的度数
const CGFloat perMinuteA = 6;

//时针每一小时旋转的度数
const CGFloat perHourA = 30;

//时针每一分钟旋转的度数
const CGFloat perMinuteHourA = 0.5;

@interface ClockViewController ()

@property (nonatomic, strong)UIImageView *clockView;

@property (nonatomic, weak)CALayer *hourLayer;
@property (nonatomic, weak)CALayer *minuteLayer;
@property (nonatomic, weak)CALayer *secondLayer;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"时钟";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupSubviews];
    
    [self addTimer];
}

- (void)setupSubviews
{
    UIImage *clockImage = [UIImage imageNamed:@"clockIcon"];
    _clockView = [[UIImageView alloc] initWithImage:clockImage];
    _clockView.frame = CGRectMake((KSLSCREENW - clockImage.size.width)/2.0, (KSLSCREENH - clockImage.size.height)/2.0, clockImage.size.width, clockImage.size.height);
    [self.view addSubview:_clockView];
    
    [self addHourHandLayer];
    [self addMinuteHandLayer];
    [self addSecondHandLayer];
    
    [self setupNextViewButton];
}

- (void)addTimer
{
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self timeChanged];
    }];
    [self timeChanged];
}

- (void)timeChanged
{
    NSCalendar *calandar = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calandar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger currentSecond = cmp.second;
    NSInteger currentMinute = cmp.minute;
    NSInteger currentHour = cmp.hour;
    
    CGFloat secondAngle = currentSecond * perSecondA;
    self.secondLayer.transform = CATransform3DMakeRotation(angleToRad(secondAngle), 0, 0, 1);
    
    CGFloat minuteAngle = currentMinute * perMinuteA;
    self.minuteLayer.transform = CATransform3DMakeRotation(angleToRad(minuteAngle), 0, 0, 1);
    
    CGFloat hourAngle = currentHour * perHourA + currentMinute * perMinuteHourA;
    self.hourLayer.transform = CATransform3DMakeRotation(angleToRad(hourAngle), 0, 0, 1);
}

- (void)addHourHandLayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 3, 50);
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.hourLayer = layer;
    [self.clockView.layer addSublayer:layer];
}

- (void)addMinuteHandLayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 3, 70);
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.minuteLayer = layer;
    [self.clockView.layer addSublayer:layer];
}

- (void)addSecondHandLayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 1, 85);
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.secondLayer = layer;
    [self.clockView.layer addSublayer:layer];
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
    ImplicitAnimationViewController *animationView = [[ImplicitAnimationViewController alloc] init];
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
