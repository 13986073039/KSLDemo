//
//  KSLMenuItem.m
//  KSLDemo
//
//  Created by 孔森林 on 2017/1/2.
//  Copyright © 2017年 GePingTech. All rights reserved.
//

#import "KSLMenuItem.h"

@implementation KSLMenuItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image{
    KSLMenuItem *item = [[self alloc] init];
    item.title = title;
    item.image = image;
    return item;
}

@end
