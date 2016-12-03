//
//  UIImage+KSLExchangeMethod.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "UIImage+KSLExchangeMethod.h"
#import <objc/message.h>

@implementation UIImage (KSLExchangeMethod)

// 加载这个分类的时候调用
/**
 *
 交换方法实现,方法都是定义在类里面
 class_getMethodImplementation:获取方法实现
 class_getInstanceMethod:获取对象
 class_getClassMethod:获取类方法
 IMP:方法实现
 imageNamed
 Class:获取哪个类方法
 SEL:获取方法编号,根据SEL就能去对应的类找方法
 */


/**
 *  运行时
 先写一个其他方法,实现这个功能
 在分类里面不能调用super,分类木有父类
 + (UIImage *)imageNamed:(NSString *)name
 {
     [super im]
 }
 */

+ (void)load
{
    Method imageNameMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    // xmg_imageNamed
    Method xmg_imageNamedMethod = class_getClassMethod([UIImage class], @selector(ksl_imageNamed:));
    
    // 交换方法实现
    method_exchangeImplementations(imageNameMethod, xmg_imageNamedMethod);
    
}

+ (UIImage *)ksl_imageNamed:(NSString *)imageName
{
    // 1.加载图片
    UIImage *image = [UIImage ksl_imageNamed:imageName];
    // 2.判断功能
    if (image == nil) {
        NSLog(@"加载image为空");
    }
    
    return image;
}


@end
