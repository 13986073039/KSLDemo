//
//  NSObject+KSLAddProperty.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  为分类动态添加属性

#import "NSObject+KSLAddProperty.h"
#import <objc/message.h>

/**
 *动态添加NSObject属性的步骤
 1.给系统自带的NSObject添加分类
 2.在分类中声明属性的get,set方法，本质并不是真的生成成员属性，而是提供get,set方法,供外界获取
 3.在分类实现get,set方法
 4.set方法实现，把传递的值给对象关联。
 5.get方法实现，把关联的值取出来传出去
 */

// 定义关联的key
static const char *nameKey = "nameKey";

@implementation NSObject (KSLAddProperty)

- (NSString *)name
{
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self, nameKey);
}

- (void)setName:(NSString *)name
{
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
