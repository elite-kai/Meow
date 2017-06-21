//
//  MeowPlayVC.h
//  Meow
//
//  Created by Parkin on 17/6/16.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowBaseVC.h"

@class MeowAnchorModel;
@interface MeowPlayVC : MeowBaseVC

@property (nonatomic, copy) NSMutableArray *modelArray;
@property (nonatomic, strong) MeowAnchorModel *model;
@property (nonatomic, assign) NSInteger index;

@end
