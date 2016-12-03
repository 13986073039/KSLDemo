//
//  ThirdViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/11/27.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIView+KSLExtension.h"
#import "FourthViewController.h"

@interface ThirdViewController ()

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UIImageView *bottomImageView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"ThirdView";
    
    [self setupSubviews];
    [self setupNextViewButton];
}

- (void)setupSubviews
{
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.frame = self.view.bounds;
    self.bottomImageView.image = [UIImage imageNamed:@"mascot_bottom"];
    [self.view addSubview:self.bottomImageView];
    
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.frame = self.view.bounds;
    self.topImageView.image = [UIImage imageNamed:@"mascot_cover"];
    [self.view addSubview:self.topImageView];

    
    
    self.topImageView.userInteractionEnabled = YES;
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.topImageView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取当前手指所在的点
    CGPoint curP = [pan locationInView:self.topImageView];
    CGFloat rectWH = 50;
    CGFloat x = curP.x - rectWH * 0.5;
    CGFloat y = curP.y - rectWH * 0.5;
    CGRect rect =   CGRectMake(x, y, rectWH, rectWH);
    
    UIImage *aImage = [self.topImageView ksl_imageFromCurrentViewClearAtRect:rect];
    self.topImageView.image = aImage;
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
    FourthViewController *fourthView = [[FourthViewController alloc] init];
    [self.navigationController pushViewController:fourthView animated:YES];
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
