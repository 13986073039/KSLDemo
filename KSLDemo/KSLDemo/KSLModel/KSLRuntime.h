//
//  KSLRuntime.h
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSLRuntime : NSObject

+(id)ksl_dynamicCreate:(NSString*)className;

@end
