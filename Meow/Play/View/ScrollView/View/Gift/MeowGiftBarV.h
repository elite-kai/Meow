//
//  MeowGiftBarV.h
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowGiftModel;
@protocol MeowGiftBarVDelegate <NSObject>

- (void)didSelectedCell:(MeowGiftModel *)model;

@end

@interface MeowGiftBarV : UIView

@property (nonatomic, weak) id<MeowGiftBarVDelegate>delegate;

@property (nonatomic, strong) UICollectionView *giftBarCV;
@property (nonatomic, copy) NSString *pageIndex;

@end
