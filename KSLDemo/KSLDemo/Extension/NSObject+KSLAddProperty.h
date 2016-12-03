//
//  NSObject+KSLAddProperty.h
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//  为分类动态添加属性

#import <Foundation/Foundation.h>

@interface NSObject (KSLAddProperty)

/**
 *  @property在分类中，只会生成get,set方法的声明，不会生成下划线成员属性，和get,set方法的实现
 *  因此需要自己实现get set方法，这就是动态添加属性
 *  实现的方式是先写出set方法和get方法的结构，再通过一个const char *的key，将set方法中的形参同self关联起来，在get方法中通过这个key，取出相关的值
 */
@property (nonatomic, strong) NSString *name;


@end
