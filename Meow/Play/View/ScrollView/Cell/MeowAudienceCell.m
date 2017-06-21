//
//  WeowAudienceCell.m
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowAudienceCell.h"
#import "MeowAnchorModel.h"

@implementation MeowAudienceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initializa];
}

- (void)initializa
{
    
}

- (void)setModel:(MeowAnchorModel *)model
{
    _model = model;
    [_adHeadImgV sd_setImageWithURL:[NSURL URLWithString:_model.smallpic] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    [_ancStarImgV sd_setImageWithURL:[NSURL URLWithString:_model.smallpic] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    [_adStarImgV sd_setImageWithURL:[NSURL URLWithString:_model.smallpic] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    _adStarScore.text = [NSString stringWithFormat:@"%ld", _model.starlevel];
}

@end
