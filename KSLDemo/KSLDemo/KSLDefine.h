//
//  KSLDefine.h
//  KSLDemo
//
//  Created by 孔森林 on 2016/12/10.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#ifndef KSLDefine_h
#define KSLDefine_h

#define KSLSCREENW [UIScreen mainScreen].bounds.size.width
#define KSLSCREENH [UIScreen mainScreen].bounds.size.height

#define angleToRad(angle) ((angle)/180.0 * M_PI)

//#define weakObj(obj) __weak typeof(obj) weak##obj = obj;
//#define strongObj(obj) __strong typeof(obj)

#pragma mark - block
#define WEAK(point) __weak __typeof(point) weak##point = point;
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#endif /* KSLDefine_h */
