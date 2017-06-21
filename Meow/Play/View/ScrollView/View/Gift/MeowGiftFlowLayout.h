//
//  MeowGiftFlowLayout.h
//  Meow
//
//  Created by Parkin on 17/5/19.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MeowGiftFlowLayout : UICollectionViewFlowLayout

//列
@property (nonatomic, assign) NSUInteger columnCount;
//行
@property (nonatomic, assign) NSUInteger rowCount;

@property (nonatomic, strong) NSMutableArray *allAttributes;

@end
