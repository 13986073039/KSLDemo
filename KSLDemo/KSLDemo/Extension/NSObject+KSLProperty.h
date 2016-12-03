//
//  NSObject+KSLProperty.h
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (KSLProperty)

/**
 *  根据字典自动生成属性代码
 */
+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;

+ (void)searchFoodByKeyword;

@end
