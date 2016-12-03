//
//  FirstViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "NSObject+KSLProperty.h"
#import "NSObject+KSLAddProperty.h"
#import "KSLAddMethodPerson.h"
#import "KSLRuntime.h"
//#import "UIImage+KSLExchangeMethod.h"
#import "KSLStatus.h"
#import "NSObject+KSLModel.h"
#import "UIImage+KSLExtension.h"
#import "UIView+KSLExtension.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"FirstView";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self printPropertyCode];
    
    [self addPropertyToNSObject];
    
    [self addMethodToObject];
    
    //动态调用指定类的类方法
    [self callClassMethod];
    
    //类对象也是对象，也可以用performSelector
//    Class firstViewControllerClass = [FirstViewController class];
//    [firstViewControllerClass performSelector:@selector(doit)];
    
    //动态交换方法
    [self exchangeMethod];
    
    //用KVC字典转模型
    [self changeDictToModelByKVC];
    
    //用runtime字典转模型
    [self changeDictToModelByRuntime];
    
    //用runtime将字典转模型，支持多级转换
    [self changeAllDictToModelByRuntime];
    
    [self setupSubviews];
    
    [self setupNextViewButton];
}

- (void)setupSubviews
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    UIImage *image = [UIImage ksl_imageNamed:@"卡哇伊.jpg" withWatermarkText:@"水印文案"];
    //imageView.frame = CGRectMake(0, 64, image.size.width, image.size.height);
    imageView.image = image;
    
    UIImage *circleImage = [UIImage ksl_circleImageNamed:@"阿狸头像"];
    imageView.frame = CGRectMake(10, 64 + 10, circleImage.size.width, circleImage.size.height);
    //[imageView sizeToFit];
    imageView.image = circleImage;
    
    UIImage *borderImage = [UIImage ksl_imageNamed:@"阿狸头像" borderWidth:6 borderColor:[UIColor purpleColor]];
    imageView.frame = CGRectMake(10, 64 + 10, borderImage.size.width, borderImage.size.height);
    imageView.image = borderImage;
    
    //对view进行载屏
    UIImage *viewImage = [imageView ksl_imageFromCurrentView];
    NSData *data = UIImagePNGRepresentation(viewImage);
    [data writeToFile:@"/Users/senlink/Desktop/newImage.png" atomically:YES];

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
    SecondViewController *secondView = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondView animated:YES];
}

- (void)printPropertyCode
{
    // 解析Plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    // 设计模型属性代码
    [NSObject createPropertyCodeWithDict:dictArr[0][@"user"]];
}

- (void)addPropertyToNSObject
{
    NSObject *object = [[NSObject alloc] init];
    object.name = @"KSLDemo";
    NSLog(@"object.name = %@",object.name);
}

- (void)addMethodToObject
{
    KSLAddMethodPerson *person = [[KSLAddMethodPerson alloc] init];
    
    //以下写法是为了消除编译警告 "performSelector may cause a leak because its selector is unknown".
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [person performSelector:NSSelectorFromString(@"eat:") withObject:@"KSLDemo"];
#pragma clang diagnostic pop
    
}

- (void)callClassMethod
{
    id ret = [KSLRuntime ksl_dynamicCreate:@"KSLAddMethodPerson"];
    id retClass = [ret class];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [retClass performSelector:NSSelectorFromString(@"searchFoodByKeyword:") withObject:@"..萝卜.."];
#pragma clang diagnostic pop


}

- (void)exchangeMethod
{
    //    UIImage *image = [UIImage imageNamed:@"123"];
    // 1.每次使用,都需要导入头文件
    // 2.当一个项目开发太久,使用这个方式不靠谱
    [UIImage imageNamed:@"123"];
    
    // imageNamed:
    // 实现方法:底层调用xmg_imageNamed
    
    // 本质:交换两个方法的实现imageNamed和xmg_imageNamed方法
    // 调用imageNamed其实就是调用xmg_imageNamed
    
    
    // imageNamed加载图片,并不知道图片是否加载成功
    // 以后调用imageNamed的时候,就知道图片是否加载
}

- (void)changeDictToModelByKVC
{
    // 解析Plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSArray *dictArr = dict[@"statuses"];
    
    // 设计模型属性代码
    [NSObject createPropertyCodeWithDict:[dictArr[0] objectForKey:@"user"]];
    NSMutableArray *statuses = [NSMutableArray array];
    
    for (NSDictionary *dict in dictArr) {
        // 字典转模型 KVC实现字典转模型
        KSLStatus *status = [KSLStatus statusWithDict:dict];
        
        [statuses addObject:status];
        
    }
    
    NSLog(@"%@",statuses);

}

- (void)changeDictToModelByRuntime
{
    /*
     KVC:遍历字典中所有key,去模型中查找有没有对应的属性名
     runtime:遍历模型中所有属性名,去字典中查找
     */

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        KSLStatus *status = [KSLStatus modelWithDict:dict];
        [statuses addObject:status];
    }
    
    NSLog(@"%@",statuses);

}

//用runtime将字典转为模型，支持多级转换
- (void)changeAllDictToModelByRuntime
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        KSLStatus *status = [KSLStatus modelWithDict:dict];
        [statuses addObject:status];
    }
    
    NSLog(@"%@",statuses);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
