//
//  KSLUser.h
//  KSLDemo
//
//  Created by senlink on 2016/11/20.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSLUser : NSObject

@property (nonatomic, copy) NSString *profile_image_url;

@property (nonatomic, assign) BOOL vip;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger mbrank;

@property (nonatomic, assign) NSInteger mbtype;

- (void)insertToDatabase;

@end
