//
//  KSLSQLiteManager.h
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/11.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSLSQLiteManager : NSObject

/**
 *   获取当前数据库版本号，用于数据库版本升级
 */
- (NSInteger)databaseVersion;

/**
 *   数据库版本升级后，设置新的数据库版本号
 */
- (void)setDatabaseVersion:(NSInteger)newVersionNumbe;

/**
 *   升级数据库
 */
- (void)updateDatabase;

/**
 *   通过以下方式，获取单例，以其它的方式，仍可以获取实例
 */
+ (instancetype)sharedSQLiteManager;

/**
 *   打开数据库
 */
- (BOOL)openAppDatabase;

/**
 *   执行SQL语句,返回执行结果，成功还是失败
 */
- (BOOL)execSQL:(NSString *)strSql;

/**
 *   查询语句，返回查询的结果
 */
- (NSArray *)querySQL:(NSString *)strQuerySql;

@end
