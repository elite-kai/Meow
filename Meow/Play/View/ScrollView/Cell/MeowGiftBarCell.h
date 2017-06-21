//
//  MeowGiftBarCell.h
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowGiftModel;
@interface MeowGiftBarCell : UICollectionViewCell

@property (nonatomic, strong) MeowGiftModel *model;


@property (weak, nonatomic) IBOutlet UIImageView *giftImgView;
@property (weak, nonatomic) IBOutlet UILabel *giftCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end
