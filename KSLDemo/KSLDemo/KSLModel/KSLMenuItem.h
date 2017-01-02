//
//  KSLMenuItem.h
//  KSLDemo
//
//  Created by 孔森林 on 2017/1/2.
//  Copyright © 2017年 GePingTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KSLMenuItem : NSObject

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, copy)NSString *title;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
