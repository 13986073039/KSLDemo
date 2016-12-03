//
//  SecondViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
//#import "UIImage+KSLExchangeMethod.h"
#import "UIImage+KSLExtension.h"
#import "UIView+KSLExtension.h"

@interface SecondViewController ()

//手指开始点
@property(nonatomic,assign)CGPoint startP;
//遮盖
@property(nonatomic,strong) UIView *coverView;

@property (strong, nonatomic) UIImageView *imageV;


@end

@implementation SecondViewController


//懒加载遮盖,保存遮盖只创建一次.
-(UIView *)coverView{
    
    if (_coverView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        [self.view addSubview:view];
        _coverView = view;
    }
    return _coverView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Second View";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImage *image = [UIImage imageNamed:@"lucky_bucuo"];
    //image = [UIImage ksl_imageNamed:@"lucky_bucuo" withWatermarkText:@""];
    self.imageV = [[UIImageView alloc] init];
    self.imageV.frame = CGRectMake((self.view.bounds.size.width - image.size.width)/2.0, (self.view.bounds.size.height - image.size.height)/2.0, image.size.width, image.size.height);
    self.imageV.image = image;
    [self.view addSubview:self.imageV];
    
    //self.imageV.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    
    [self setupNextViewButton];
}


- (IBAction)pan:(UIPanGestureRecognizer *)pan{
    //获取当前手指所在的点.
    CGPoint curP = [pan locationInView:self.imageV];
    if(pan.state == UIGestureRecognizerStateBegan){
        
        CGPoint startP = curP;
        self.startP = startP;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        
        CGFloat offsetX = curP.x - self.startP.x;
        CGFloat offsetY = curP.y - self.startP.y;
        //确定遮盖的区域位置
        CGRect rect = CGRectMake(self.startP.x + self.imageV.frame.origin.x, self.startP.y + self.imageV.frame.origin.y, offsetX, offsetY);
        //每次移动时,调用遮盖的Frame.
        self.coverView.frame = rect;
        
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        
//        
//        //1.开启一个跟原始图片相同大小的图片上下文.
//        UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
//        //把self.cover.frame 设为裁剪区域
//        CGRect frame = self.coverView.frame;
//        frame.origin.x -= self.imageV.frame.origin.x;
//        frame.origin.y -= self.imageV.frame.origin.y;
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
//        [path addClip];
//        //获取当前上下文.
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        //把UIImageView当中的图片给绘制上下文当中.
//        [self.imageV.layer renderInContext:ctx];
//        //从上下文当中生成一张新的图片
//        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//        //关闭上下文.
//        UIGraphicsEndImageContext();
//        //给图片重新赋值
//        self.imageV.image = newImage;
//        
        
        CGRect rect = self.coverView.frame;
        rect.origin.x -= self.imageV.frame.origin.x;
        rect.origin.y -= self.imageV.frame.origin.y;
        UIImage *aImage = [self.imageV ksl_imageFromCurrentViewWithRect:rect];
        self.imageV.image = aImage;
        
        //移除遮盖
        [self.coverView removeFromSuperview];
        
    }
    
    
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
    ThirdViewController *thirdView = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
