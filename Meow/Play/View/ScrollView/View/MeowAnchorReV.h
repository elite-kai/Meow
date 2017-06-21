//
//  RiceAnchorReV.h
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowAnchorModel;
@interface MeowAnchorReV : UIView

@property (nonatomic, strong) MeowAnchorModel *anchorModel;

//主播头像
@property (weak, nonatomic) IBOutlet UIImageView *anchorHeadImg;
//主播名
@property (weak, nonatomic) IBOutlet UILabel *anchorName;

//观众数量
@property (weak, nonatomic) IBOutlet UILabel *audienceCount;
//金币数量
@property (weak, nonatomic) IBOutlet UILabel *goldCount;

@end
