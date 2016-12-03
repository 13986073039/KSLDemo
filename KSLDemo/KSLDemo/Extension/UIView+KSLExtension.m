//
//  UIView+KSLExtension.m
//  KSLDemo
//
//  Created by senlink on 2016/11/26.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "UIView+KSLExtension.h"

@implementation UIView (KSLExtension)

- (UIImage *)ksl_imageFromCurrentView
{
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //将view对应的layer给绘制上下文.层是通过渲染的方法给上下文的
    [self.layer renderInContext:ctx];
    //生成一张图片
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    return aImage;
}

- (UIImage *)ksl_imageFromCurrentViewWithRect:(CGRect)rect
{
    //1.开启一个跟原始view相同大小的图片上下文.
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //把rect对应的范围设为裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [path addClip];
    //获取当前上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把view的layer中的内容给图片上下文.
    [self.layer renderInContext:ctx];
    //从上下文当中生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文.
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ksl_imageFromCurrentViewClearAtRect:(CGRect)rect
{
    //开启一个图片上下文.
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //获取当前的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把view上面的内容给绘制到上下文.
    [self.layer renderInContext:ctx];
    //擦除指定区域，擦除后的区域透明
    CGContextClearRect(ctx, rect);
    //生成一张新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //把上下文给关闭
    UIGraphicsEndImageContext();
    //给原来图片重新赋值
    return newImage;
}
@end
