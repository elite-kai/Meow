//
//  RiceAnchorReV.m
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowAnchorReV.h"
#import "MeowAnchorModel.h"

@implementation MeowAnchorReV

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializa];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initializa];
}

- (void)initializa
{
    
}

- (void)setAnchorModel:(MeowAnchorModel *)anchorModel
{
    _anchorModel = anchorModel;
     [_anchorHeadImg sd_setImageWithURL:[NSURL URLWithString:_anchorModel.smallpic] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    _anchorName.text = _anchorModel.myname;
    _audienceCount.text = [NSString stringWithFormat:@"%ld", _anchorModel.allnum];
    _goldCount.text = [NSString stringWithFormat:@"%ld", _anchorModel.lrCurrent];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
