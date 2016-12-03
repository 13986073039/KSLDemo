//
//  KSLRuntime.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLRuntime.h"
#import <objc/message.h>

@implementation KSLRuntime

+(id)ksl_dynamicCreate:(NSString*)className{
    id aClass = objc_getClass([className UTF8String]);
    return aClass;
}

@end
