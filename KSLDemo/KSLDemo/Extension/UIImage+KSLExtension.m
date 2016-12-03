//
//  UIImage+KSLExtension.m
//  KSLDemo
//
//  Created by senlink on 2016/11/26.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "UIImage+KSLExtension.h"

@implementation UIImage (KSLExtension)

+ (UIImage *)ksl_imageNamed:(NSString *)strImageName withWatermarkText:(NSString *)strWatermark
{
    UIImage *image = [UIImage imageNamed:strImageName];
    //开启跟图片相同大小的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    //把图片绘制到图片上下文
    [image drawAtPoint:CGPointZero];
    //绘制水印文字
    [strWatermark drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    //生成图片
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    return aImage;
}

+ (UIImage *)ksl_circleImageNamed:(NSString *)strImageName
{
    //加载图片
    UIImage *image = [UIImage imageNamed:strImageName];
    //生成一个跟图片相同大小的图片上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //生成一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //把路径设置成为裁剪区域
    [path addClip];
    //把图片绘制到图片上下文
    [image drawAtPoint:CGPointZero];
    //生成裁剪后的图片
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    return aImage;
}

+ (UIImage *)ksl_imageNamed:(NSString *)strImageName borderWidth:(CGFloat)borderW borderColor:(UIColor *)color
{
    //获取图片
    UIImage *image = [UIImage imageNamed:strImageName];
    //开启图片上下文
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //先描述外圈的路径，设置填充颜色
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    //再描述内圈路径，把内圈设置成图片的裁剪区域
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    [path addClip];
    [image drawInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    //生成新的图片
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    return aImage;
}

@end
