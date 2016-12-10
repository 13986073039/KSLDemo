//
//  UIColor+KSLExtension.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/10.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "UIColor+KSLExtension.h"

@implementation UIColor (KSLExtension)

+ (UIColor *)ksl_randomColor
{
    CGFloat red = arc4random_uniform(256)/255.0;
    CGFloat green = arc4random_uniform(256)/255.0;
    CGFloat blue = arc4random_uniform(256)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
