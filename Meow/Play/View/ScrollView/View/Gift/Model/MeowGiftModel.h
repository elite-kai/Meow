//
//  MeowGiftModel.h
//  Meow
//
//  Created by Parkin on 17/5/24.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeowGiftModel : NSObject

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *giftName;
@property (nonatomic, assign) CGFloat giftPrice;
@property (nonatomic, assign) NSInteger giftCount;

@end
