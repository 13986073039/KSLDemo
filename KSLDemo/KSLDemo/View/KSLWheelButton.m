//
//  KSLWheelButton.m
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/23.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "KSLWheelButton.h"

@implementation KSLWheelButton


//返回按钮当中的UIImageView的尺寸位置.
//contentRect:当前按钮的尺寸位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat w = 40;
    CGFloat h = 50;
    CGFloat x= (contentRect.size.width - w) * 0.5;
    CGFloat y = 20;
    
    return CGRectMake(x, y, w, h);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
