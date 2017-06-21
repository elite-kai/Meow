//
//  MeowMacro.h
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#ifndef MeowMacro_h
#define MeowMacro_h


typedef void(^ReturnValueBlcok)(id returnValue);
typedef void(^ErrorCodeBlock)(id errorCode);
typedef void(^FailureBlock)();

/**
 *  获取屏幕bounds
 */

#define iPhone4 ([UIScreen mainScreen].bounds.size.height==480?YES:NO)
#define iPhone5 ([UIScreen mainScreen].bounds.size.height==568?YES:NO)
#define iPhone6 ([UIScreen mainScreen].bounds.size.height==667?YES:NO)
#define iPhone6_plus ([UIScreen mainScreen].bounds.size.height==736?YES:NO)

#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width


// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//清除背景色
#define CLEARCOLOR [UIColor clearColor]


// 获取系统版本
#define kSystemVersion  [[UIDevice currentDevice].systemVersion floatValue]

#endif /* MeowMacro_h */
