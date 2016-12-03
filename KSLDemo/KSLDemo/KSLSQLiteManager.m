//
//  KSLSQLiteManager.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/11.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLSQLiteManager.h"
#import <sqlite3.h>

@interface KSLSQLiteManager ()

@property (nonatomic, assign)sqlite3 *db;

@end

static KSLSQLiteManager *_sharedManager = nil;

@implementation KSLSQLiteManager

+ (instancetype)sharedSQLiteManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
        [_sharedManager setupDatabase];
    });
    return _sharedManager;
}

- (BOOL)openAppDatabase
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [filePath stringByAppendingPathComponent:@"demo_0.sqlite"];
    
    if (sqlite3_open(filePath.UTF8String, &_db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    else
    {
        NSLog(@"%@",filePath);
    }
    return YES;
}

- (void)setupDatabase
{
    if ([self openAppDatabase]) {
        [self updateDatabase];
    }
}

- (BOOL)execSQL:(NSString *)strSql
{
    return sqlite3_exec(self.db, strSql.UTF8String, nil, nil, nil) == SQLITE_OK;
}

- (void)updateDatabase
{
    if ([self databaseVersion] == 0) {
        
        NSString *strCreateAppSQL = [NSString stringWithFormat:@"create table if not exists  t_app(id integer not null primary key,name text,value integer)"];
        [self execSQL:strCreateAppSQL];
        
        NSString *strInsertAppSQL = [NSString stringWithFormat:@"insert into t_app(name,value) values('%@',%d)",@"databaseVersion",0];
        [self execSQL:strInsertAppSQL];

        NSString *strCreateStudentSQL = @"create table if not exists 't_student' (id integer not null primary key, name text, age integer);";
        [self execSQL:strCreateStudentSQL];
        
        NSString *strCreateUserSQL = @"create table if not exists t_user (id integer not null primary key,url text,vip integer,name text,mbrank integer,mbtype integer)";
        [self execSQL:strCreateUserSQL];
        
        [self setDatabaseVersion:1];
    }
    
    if ([self databaseVersion] == 1) {
        NSString *strCreateTableSQL = @"create table if not exists 't_person_1' (id integer not null primary key, name text, age integer);";
        [self execSQL:strCreateTableSQL];
        [self setDatabaseVersion:2];
    }
}

- (NSArray *)querySQL:(NSString *)strQuerySql
{
    // 定义游标对象
    sqlite3_stmt *stmt = nil;
    
    // 准备查询
    // 1> 参数一:数据库对象
    // 2> 参数二:查询语句
    // 3> 参数三:查询语句的长度:-1
    // 4> 参数四:句柄(游标对象)
    if (sqlite3_prepare_v2(self.db, strQuerySql.UTF8String, -1, &stmt, nil) != SQLITE_OK) {
        NSLog(@"准备查询失败");
        return nil;
    };
    
    // 准备成功,开始查询数据
    NSMutableArray *dictArray = [NSMutableArray array];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        // 获取一共多少列
        int count = sqlite3_column_count(stmt);
        
        // 定义字典
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (int i = 0; i < count; i++) {
            // 取出i位置列的字段名,作为字典的键
            const char *cKey = sqlite3_column_name(stmt, i);
            NSString *key = [NSString stringWithUTF8String:cKey];
            
            // 取出i位置的存储的值,作为字典的值
            const char *cValue = (const char *)sqlite3_column_text(stmt, i);
            NSString *value = [NSString stringWithUTF8String:cValue];
            
            // 将键值对一个一个放入字典中
            [dict setValue:value forKey:key];
        }
        
        // 将获取的字典放入数组中
        [dictArray addObject:dict];
    }
    
    // 返回取出所有数据的数组
    return dictArray;
}


-(NSInteger)getApplicationProperty:(NSString *)propertyName {
    
    NSArray *rows = [self querySQL:[NSString stringWithFormat:@"select value from t_app where name = '%@'",propertyName]];
    
    if ([rows count] == 0) {
        return 0;
    }
    
    id object = [[rows lastObject] objectForKey:@"value"];
    if ([object isKindOfClass:[NSString class]]) {
        object = [NSNumber numberWithInteger:[(NSString *)object integerValue]];
    }
    return [(NSNumber *)object integerValue];
}

-(void)setDatabaseVersion:(NSInteger)newVersionNumber {
    return [self updateApplicationProperty:@"databaseVersion" value:newVersionNumber];
}

-(void)updateApplicationProperty:(NSString *)propertyName value:(NSInteger)value {
    
    [self execSQL:[NSString stringWithFormat:@"update t_app set value = %ld where name = '%@'",value,propertyName]];
}


-(NSInteger)databaseVersion {
    return [self getApplicationProperty:@"databaseVersion"];
}


@end
