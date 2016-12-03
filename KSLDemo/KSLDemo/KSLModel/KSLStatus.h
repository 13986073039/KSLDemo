//
//  KSLStatus.h
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KSLUser;

@interface KSLStatus : NSObject

// 写一段程序自动生成属性代码

@property (nonatomic, assign) NSInteger ID;

// 解析字典自动生成属性代码
@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) NSInteger reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) int comments_count;

//user这一字段，要和字典中的关键字保持一致
@property (nonatomic, strong) KSLUser *user;

@property (nonatomic, strong) NSDictionary *retweeted_status;

// 模型的属性名跟字典一一对应

+ (__kindof KSLStatus *)statusWithDict:(NSDictionary *)dict;


@end
