//
//  UIImage+KSLExtension.h
//  KSLDemo
//
//  Created by senlink on 2016/11/26.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KSLExtension)

/**
 *  给指定图片加上文字水印
 */
+ (nullable UIImage *)ksl_imageNamed:(nullable NSString *)strImageName withWatermarkText:(nullable NSString *)strWatermark;

/**
 *  指定图片对应的圆图
 */
+ (nullable UIImage *)ksl_circleImageNamed:(nullable NSString *)strImageName;

/**
 *  指定图片带有边框的圆图
 */
+ (nullable UIImage *)ksl_imageNamed:(nullable NSString *)strImageName borderWidth:(CGFloat)borderW borderColor:(nonnull UIColor *)color;
@end
