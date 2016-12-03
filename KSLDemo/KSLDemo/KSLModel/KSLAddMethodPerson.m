//
//  KSLAddMethodPerson.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLAddMethodPerson.h"
#import <objc/message.h>

@implementation KSLAddMethodPerson

// 定义函数
// 没有返回值,参数(id,SEL)
// void(id,SEL)
void aaaa(id self, SEL _cmd, id param1)
{
    NSLog(@"调用eat %@ %@ %@",self,NSStringFromSelector(_cmd),param1);
}

void searchByKeyword(id self, SEL _cmd, id keyword)
{
    NSLog(@"searchBy:%@",keyword);
}

// 默认一个方法都有两个参数,self,_cmd,隐式参数
// self:方法调用者
// _cmd:调用方法的编号

// 动态添加方法,首先实现这个resolveInstanceMethod
// resolveInstanceMethod调用:当调用了没有实现的方法没有实现就会调用resolveInstanceMethod
// resolveInstanceMethod作用:就知道哪些方法没有实现,从而动态添加方法
// sel:没有实现方法

//动态添加实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    //    NSLog(@"%@",NSStringFromSelector(sel));
    
    // 动态添加eat方法
    //为了消除Undeclared selector 'eat'警告，可以才用以下写法
    if (sel == NSSelectorFromString(@"eat:")) {
        
        /*
         cls:给哪个类添加方法
         SEL:添加方法的方法编号是什么
         IMP:方法实现,函数入口,函数名
         types:方法类型
         */
        // @:对象 :SEL
        class_addMethod(self, sel, (IMP)aaaa, "v@:@");
        
        // 处理完
        return YES;

    }
    
    //以下写法会有编译警告
//    if (sel == @selector(eat:)) {
//        
//        /*
//         cls:给哪个类添加方法
//         SEL:添加方法的方法编号是什么
//         IMP:方法实现,函数入口,函数名
//         types:方法类型
//         */
//        // @:对象 :SEL
//        class_addMethod(self, sel, (IMP)aaaa, "v@:@");
//        
//        
//        // 处理完
//        return YES;
//        
//    }
    
    return [super resolveInstanceMethod:sel];
}

//动态添加类方法
+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == NSSelectorFromString(@"eat:")) {
        
        /*
         cls:给哪个类添加方法
         SEL:添加方法的方法编号是什么
         IMP:方法实现,函数入口,函数名
         types:方法类型
         */
        // @:对象 :SEL
        Class metaClass = object_getClass(self);
        class_addMethod(metaClass, sel, (IMP)aaaa, "v@:@");
        
        
        // 处理完
        return YES;
        
    }
    else if (sel == NSSelectorFromString(@"searchFoodByKeyword:")) {
        Class metaClass = object_getClass(self);
        class_addMethod(metaClass, sel, (IMP)searchByKeyword, "v@:@");
        return YES;
    }
    
    return [super resolveClassMethod:sel];
    
}


@end
