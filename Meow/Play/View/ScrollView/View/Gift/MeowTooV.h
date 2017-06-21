//
//  MeowTooV.h
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeowTooVDelegate <NSObject>

//键盘
- (void)chatKeyboard:(NSMutableString *)chatStr;
//分享
- (void)sharingPlatform:(NSMutableString *)shareStr;
//贡献
- (void)contributionList:(NSMutableString *)contrStr;
//礼物
- (void)giftBarView:(NSMutableString *)giftStr;

@end

@interface MeowTooV : UIView

@property (nonatomic, weak) id<MeowTooVDelegate>delegate;

@end
