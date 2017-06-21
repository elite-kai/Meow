//
//  MeowHotCell.h
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeowAnchorModel.h"

@interface MeowHotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *anchorPhotosImgView;



@property (nonatomic, strong) MeowAnchorModel *hotModel;

@end
