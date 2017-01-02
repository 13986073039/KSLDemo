//
//  KSLItemButton.m
//  KSLDemo
//
//  Created by 孔森林 on 2017/1/2.
//  Copyright © 2017年 GePingTech. All rights reserved.
//

#import "KSLItemButton.h"

@implementation KSLItemButton


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUP];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}


//按钮的初始化
- (void)setUP{
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//
//}

//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.8;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    CGFloat labelX = imageX;
    CGFloat labelY = imageH;
    CGFloat labelW = imageW;
    CGFloat labelH = self.bounds.size.height - imageH;
    
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}


@end
