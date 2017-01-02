//
//  KSLWheelView.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/23.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLWheelView.h"
#import "KSLWheelButton.h"

@interface KSLWheelView ()<CAAnimationDelegate>

@property (nonatomic, weak)UIImageView *contentView;
@property (nonatomic, weak)UIButton *preBtn;
@property (nonatomic, strong)CADisplayLink *link;

@end



@implementation KSLWheelView


-(CADisplayLink *)link{
    
    if (_link == nil) {
        
        CADisplayLink *link  = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
        
    }
    return _link;
    
}

//开始旋转
-(void)start{
    
    
    self.link.paused = NO;
    
}
- (void)update{
    
    //让转盘开始旋转
    self.contentView.transform = CGAffineTransformRotate(self.contentView.transform, M_PI / 200.0);
    
}


//暂停旋转
- (void)stop{
    
    self.link.paused = YES;
    
    
}
//开始选号
- (void)startChoose:(id)sender {
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    NSNumber *rotationRad = @(M_PI * 2/* - angleToRad(self.preBtn.tag * 30)*/);
    anim.toValue = rotationRad;
    anim.duration = 1;
    anim.delegate = self;
//    anim.fillMode = kCAFillModeForwards;
//    anim.removedOnCompletion = NO;
    //anim.autoreverses = NO;
    
    [self.contentView.layer addAnimation:anim forKey:nil];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LuckyRotateWheel"]];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        
        KSLWheelButton *btn = [KSLWheelButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 81, 81);
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _contentView = imageView;
        _preBtn = btn;
        
        //imageView.center = self.center;
        btn.center = imageView.center;
        
        //添加按钮
        [self setUP];
    }
    return self;
}

//添加按钮
- (void)setUP{
    
    
    self.contentView.userInteractionEnabled = YES;
    //创建按钮
    
    CGFloat btnW = 68;
    CGFloat btnH = 143;
    CGFloat angle = 0;
    
    //在C语言当中用的都是像素,我们这个地方加载@2x
    
    //加载原始图片
    UIImage *oriImage = [UIImage imageNamed:@"LuckyAnimal"];
    UIImage *oriSelImage = [UIImage imageNamed:@"LuckyAnimalPressed"];
    
    
    //获取当前屏幕与像素坐标的比例
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGFloat clipW = oriImage.size.width / 12 * scale;
    CGFloat clipH = oriImage.size.height * scale;
    CGFloat clipX = 0;
    CGFloat clipY = 0;
    
    
    
    for(int i = 0; i < 12;i++){
        
        KSLWheelButton *btn = [KSLWheelButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的尺寸
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        
        //      btn.imageView.contentMode = UIViewContentModeCenter;
        
        
        //裁剪图片当中的某一块区域
        clipX = i * clipW;
        CGRect rect = CGRectMake(clipX, clipY, clipW, clipH);
        //裁剪正常状态下的图片
        CGImageRef clipImage = CGImageCreateWithImageInRect(oriImage.CGImage, rect);
        //裁剪选中状态下的图片.
        CGImageRef clipSelImage = CGImageCreateWithImageInRect(oriSelImage.CGImage, rect);
        
        
        //设置按钮的图片
        //把CGImageRef转成UIImage
        UIImage *clipNewImage = [UIImage imageWithCGImage:clipImage];
        [btn setImage:clipNewImage forState:UIControlStateNormal];
        
        //设置选中状态下的图片.
        UIImage *clipSelNewImage = [UIImage imageWithCGImage:clipSelImage];
        [btn setImage:clipSelNewImage forState:UIControlStateSelected];
        
        
        
        //设置选中的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        //监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //添加按钮
        [self.contentView addSubview:btn];
        btn.tag = i;
        
        //让每个按钮进行旋转
        btn.transform = CGAffineTransformMakeRotation(angle / 180.0 * M_PI);
        angle += 30;
        
        //让第一个按钮成为选中状态.
        if(i == 0){
            [self btnClick:btn];
        }
        
    }
    
    
}


//当按钮点击的时候调用
- (void)btnClick:(UIButton *)btn{
    
//    self.contentView.transform = CGAffineTransformRotate(self.contentView.transform, self.preBtn.tag * 30/180 * M_PI);
    
    //让上一个选中按钮取消选中的状态
    self.preBtn.selected = NO;
    //让当前选中的按钮成为选中状态.
    btn.selected = YES;
    //把当前的按钮赋值给上一个按钮
    self.preBtn = btn;
    
    
}


//当核心动画停止的时候调用.
-(void)animationDidStop:(nonnull CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%s",__func__);
    
    //拿当选中按钮的旋转角度.
    CGAffineTransform transform = self.preBtn.transform;
    CGFloat angel = atan2f(transform.b, transform.a);
    //让contentView倒着旋转回去.
    self.contentView.transform = CGAffineTransformMakeRotation(-angel);
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    NSLog(@"[--dealloc: %@--]",NSStringFromClass(self.class));
}


@end
