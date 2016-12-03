//
//  KSLStatus.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLStatus.h"

@implementation KSLStatus

+ (KSLStatus *)statusWithDict:(NSDictionary *)dict
{
    KSLStatus *status = [[self alloc] init];
    
    // KVC实现字典转模型
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}

// 解决KVC报错,即字典关键字与模型字段不一致的情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
    // key:没有找到key
    // value:没有找到key对应的值
    NSLog(@"%@ %@",key,value);
}


@end
