//
//  MeowPlayScrollV.h
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowAnchorModel;
@interface MeowPlayScrollV : UIScrollView

- (id)initWithFrame:(CGRect)frame withModel:(MeowAnchorModel *)model;

@property (nonatomic, strong) MeowAnchorModel *model;

@end
