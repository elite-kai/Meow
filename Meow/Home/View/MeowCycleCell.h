//
//  MeowCycleCell.h
//  Meow
//
//  Created by Parkin on 17/4/27.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;

@class MeowADModel;
@interface MeowCycleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;

@property (nonatomic, copy) NSArray *modelArr;

@end
