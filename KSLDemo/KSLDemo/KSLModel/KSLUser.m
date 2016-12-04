//
//  KSLUser.m
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLUser.h"
#import "KSLSQLiteManager.h"

@implementation KSLUser

- (void)insertToDatabase
{
    NSString *strInsertSQL = [NSString stringWithFormat:@"insert into t_user(url,vip,name,mbrank,mbtype) values('%@',%d,'%@','%ld','%ld')",self.profile_image_url,self.vip,self.name,self.mbrank,self.mbtype];
    if ([[KSLSQLiteManager sharedSQLiteManager] execSQL:strInsertSQL]) {
        NSLog(@"数据插入成功");
    }
    else
    {
        NSLog(@"数据插入失败");
    }
}

#pragma mark - NSCopying NSMutableCopying
-(id)copyWithZone:(NSZone *)zone
{
    KSLUser *aUser = [[self class] allocWithZone:zone];
    [self assignUser:aUser];
    return aUser;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    KSLUser *aUser = [[self class] allocWithZone:zone];
    [self assignUser:aUser];
    return aUser;
}

- (void)assignUser:(KSLUser *)aUser
{
    aUser.profile_image_url = _profile_image_url;
    aUser.vip = _vip;
    aUser.name = _name;
    aUser.mbrank = _mbrank;
    aUser.mbtype = _mbtype;
}

@end
