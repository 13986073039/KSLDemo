//
//  KSLComponentViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2017/1/2.
//  Copyright © 2017年 GePingTech. All rights reserved.
//

#import "KSLComponentViewController.h"
#import "KSLItemButton.h"
#import "KSLMenuItem.h"

@interface KSLComponentViewController ()

@property(nonatomic,strong)NSMutableArray *btnArray;

@property(nonatomic,assign)int btnIndex;

@property(nonatomic,strong)NSTimer *timer;

@property (nonatomic, assign)CGPoint prevousPoint;

@end


@implementation KSLComponentViewController


-(NSMutableArray *)btnArray{
    
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addBtn];
    
    //添加定时器
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
}
//每隔0.1秒调用一次

- (void)update{
    
    //如果当前的角标等于当前按钮的个数
    //让定时器停止
    if (self.btnIndex == self.btnArray.count) {
        [self.timer invalidate];
        return;
    }
    //每次取出一个按钮
    UIButton *btn = self.btnArray[self.btnIndex];
    //取消所有形变
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        btn.transform = CGAffineTransformIdentity;
        
    } completion:nil];
    self.btnIndex++;
}


//-(void)viewDidAppear:(BOOL)animated{
//
//    for (UIButton *btn in self.btnArray) {
//        [UIView animateWithDuration:1 animations:^{
//            btn.transform = CGAffineTransformIdentity;
//        }];
//    }
//
//}


//添加按钮
- (void)addBtn{
    
    CGFloat btnWH = 100;
    
    int cloumn = 3;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cloumn * btnWH) / (cloumn + 1);
    CGFloat x = 0;
    CGFloat y = 0;
    int curCloumn = 0;
    int curRow = 0;
    CGFloat oriY = 300;
    
    for(int i = 0 ;i < self.itemArray.count; i++){
        
        KSLItemButton *btn = [KSLItemButton buttonWithType:UIButtonTypeCustom];
        //当前所在的列
        curCloumn = i % cloumn;
        //当前所在的行
        curRow = i / cloumn;
        
        x = margin + (btnWH + margin) * curCloumn;
        y =(btnWH + margin) * curRow + oriY;
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
        
        KSLMenuItem *item = self.itemArray[i];
        //设置按钮图片
        [btn setImage:item.image forState:UIControlStateNormal];
        //设置按钮的文字
        [btn setTitle:item.title forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        //开始时让所有按钮都移动到最底部
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        [self.btnArray addObject:btn];
        
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    }
}







//当手指按下进调用
- (void)btnClick:(UIButton *)btn{
    
    //self.view.transform = CGAffineTransformIsIdentity(<#CGAffineTransform t#>)
    
    //CGAffineTransformIdentity为最初状态，即最初位置的中心点
    //self.view.transform = CGAffineTransformIdentity
    
    //CGAffineTransformTranslate每次都是以传入的transform为起始参照
    //self.view.transform = CGAffineTransformTranslate(<#CGAffineTransform t#>, <#CGFloat tx#>, <#CGFloat ty#>)
    
    //CGAffineTransformMakeTranslation每次都是以最初位置的中心点为起始参照
    //self.view.transform = CGAffineTransformMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>)
    
    
    //让按钮放大
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    
}

//当手指抬起时调用.
- (void)btnClick1:(UIButton *)btn{
    //让按钮放大.变成透明
    [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 0;
        btn.transform = CGAffineTransformMakeScale(2, 2);
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.prevousPoint = [[touches anyObject] locationInView:self.view];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    if (endPoint.y - self.prevousPoint.y > 10) {
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }
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
