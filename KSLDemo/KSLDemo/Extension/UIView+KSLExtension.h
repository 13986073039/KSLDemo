//
//  UIView+KSLExtension.h
//  KSLDemo
//
//  Created by senlink on 2016/11/26.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KSLExtension)

/**
 *  对当前view进行截屏
 */
- (nullable UIImage *)ksl_imageFromCurrentView;

/**
 *  对当前view的特定范围进行截屏
 */
- (nullable UIImage *)ksl_imageFromCurrentViewWithRect:(CGRect)rect;

/**
 *  对当前view的特写范围进行擦除
 */
- (nullable UIImage *)ksl_imageFromCurrentViewClearAtRect:(CGRect)rect;
@end
