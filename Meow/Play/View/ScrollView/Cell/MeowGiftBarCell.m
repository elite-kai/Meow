//
//  MeowGiftBarCell.m
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowGiftBarCell.h"
#import "MeowGiftModel.h"

@implementation MeowGiftBarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

//针对于uicollectionview左右滑动的时候只调用一次，所以需要在dataSource方法中手动调用
- (void)layoutSubviews
{
    [super layoutSubviews];
 
    self.giftImgView.image = [UIImage imageNamed:self.model.imgUrl];
    self.giftNameLabel.text = self.model.giftName;
    self.giftPriceLabel.text = [NSString stringWithFormat:@"%f", self.model.giftPrice];
    self.giftCountLabel.text = [NSString stringWithFormat:@"%ld", self.model.giftCount];
}

- (void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    if (selected) {
        self.selectedView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
//            self.selectedView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            self.transform = CGAffineTransformIdentity;
//            self.selectedView.transform = CGAffineTransformIdentity;
        }];
        
        //选中时
    }else{
        //非选中
        self.selectedView.hidden = YES;
//        [self.model setValue:@0 forKey:@"giftCount"];
    }
    
    // Configure the view for the selected state
}

@end
