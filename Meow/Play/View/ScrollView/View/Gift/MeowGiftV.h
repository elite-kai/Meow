//
//  MeowGiftV.h
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowPageControl;
@class MeowGiftBarV;
@interface MeowGiftV : UIView

@property (weak, nonatomic) IBOutlet MeowGiftBarV *giftBarV;
@property (weak, nonatomic) IBOutlet MeowPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *giftInfoLabel;



@end
