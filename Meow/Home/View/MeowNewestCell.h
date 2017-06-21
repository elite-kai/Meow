//
//  MeowNewestCell.h
//  Meow
//
//  Created by Parkin on 17/4/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowNewestModel;
@interface MeowNewestCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *anchorName;
@property (weak, nonatomic) IBOutlet UIImageView *anchorHeader;
@property (weak, nonatomic) IBOutlet UILabel *anchorStatus;
@property (weak, nonatomic) IBOutlet UILabel *anchorAddress;

@property (nonatomic, strong) MeowNewestModel *newestModel;

@end
