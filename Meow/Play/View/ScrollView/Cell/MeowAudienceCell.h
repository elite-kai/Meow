//
//  WeowAudienceCell.h
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowAnchorModel;
@interface MeowAudienceCell : UICollectionViewCell

@property (nonatomic, strong) MeowAnchorModel *model;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *adHeadImgV;
//作为一个主播的星级
@property (weak, nonatomic) IBOutlet UIImageView *ancStarImgV;
//作为一个观众的星级
@property (weak, nonatomic) IBOutlet UIImageView *adStarImgV;
//作为一个观众的星级数
@property (weak, nonatomic) IBOutlet UILabel *adStarScore;


@end
