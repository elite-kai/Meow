//
//  MeowPlayCell.h
//  Meow
//
//  Created by Parkin on 17/5/2.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowAnchorModel, MeowPlayView, MeowPlayScrollV;
@interface MeowPlayCell : UITableViewCell

@property (nonatomic, copy) NSString *imgStr;

@property (nonatomic, strong) MeowAnchorModel *model;
@property (nonatomic, strong) MeowPlayView *playView;
@property (nonatomic, strong) MeowPlayScrollV *playScrollV;

@end
