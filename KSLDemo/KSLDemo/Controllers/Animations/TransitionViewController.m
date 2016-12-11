//
//  TransitionViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/12/11.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  转场动画

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, assign)NSInteger imageIndex;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"转场动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupSubviews];
}

- (void)setupSubviews
{
    UIView *bgView = [[UIView alloc] init];
    UIImage *aImage = [UIImage imageNamed:@"page_1"];
    UIImageView *aImageView = [[UIImageView alloc] initWithImage:aImage];
    [self.view addSubview:bgView];
    [bgView addSubview:aImageView];
    
    bgView.bounds = CGRectMake(0, 0, aImage.size.width, aImage.size.height);
    aImageView.bounds = CGRectMake(0, 0, aImage.size.width, aImage.size.height);
    bgView.layer.anchorPoint = CGPointMake(0, 0);
    aImageView.layer.anchorPoint = CGPointMake(0, 0);
    CGFloat offsetX = (KSLSCREENW - aImage.size.width) * 0.5;
    CGFloat offsetY = (KSLSCREENH -64 - aImage.size.height) * 0.5;
    bgView.layer.position = CGPointMake(offsetX,offsetY + 64);
    aImageView.layer.position = CGPointMake(0,0);
    
    self.imageView = aImageView;
    
    //bgView.center = self.view.center;
    //aImageView.center = self.view.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self UIViewTransition];
    [self CATransitionView];
}

- (void)CATransitionView
{
    //转场代码必须得要和转场动画在同一个方法当中.两者的相对位置没有要求
    //创建动画
    CATransition *anim = [CATransition animation];
    
    //设置转场类型
    anim.type = @"pageCurl";
    
    //设置转场的方向
    anim.subtype = kCATransitionFromBottom;
    //设置动画的开始点.
    anim.startProgress = 0.2;
    //设置动画的结束点.
    anim.endProgress = 0.8;
    
    anim.duration = 2;
    [self.imageView.layer addAnimation:anim forKey:nil];
    
    
    //转场代码
    _imageIndex++;
    if (_imageIndex > 3) {
        _imageIndex = 1;
    }
    NSString *imageName = [NSString stringWithFormat:@"page_%ld",_imageIndex];
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)UIViewTransition
{
    [UIView transitionWithView:self.imageView duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        _imageIndex++;
        if (_imageIndex > 3) {
            _imageIndex = 1;
        }
        NSString *imageName = [NSString stringWithFormat:@"page_%ld",(long)_imageIndex];
        self.imageView.image = [UIImage imageNamed:imageName];
        
        
    } completion:nil];

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
