//
//  CYTabBar.h
//  蚁巢
//
//  Created by 张春雨 on 2016/11/17.
//  Copyright © 2016年 张春雨. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CYCenterButton.h"
@class CYButton;
@class CYTabBar;

/*! 委托 */
@protocol CYTabBarDelegate <NSObject>
@required
- (void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton;
@end

@interface CYTabBar : UIView
/** tabbar按钮显示信息 */
@property(copy, nonatomic) NSArray<UITabBarItem *> *items;
/** 设置文字颜色 */
@property (strong , nonatomic) UIColor *textColor;
/** 设置选中颜色 */
@property (strong , nonatomic) UIColor *selectedTextColor;
/** 其他按钮 */
@property (strong , nonatomic) NSMutableArray <CYButton*>*btnArr;
/** 中间按钮 */
@property (strong , nonatomic) CYCenterButton *centerBtn;
/** 委托 */
@property(weak , nonatomic) id<CYTabBarDelegate>delegate;

@end
