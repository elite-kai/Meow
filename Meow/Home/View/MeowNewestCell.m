//
//  MeowNewestCell.m
//  Meow
//
//  Created by Parkin on 17/4/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowNewestCell.h"
#import "MeowNewestModel.h"

@implementation MeowNewestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewestModel:(MeowNewestModel *)newestModel
{
    _newestModel = newestModel;
    //设置封面头像
    [_anchorHeader sd_setImageWithURL:[NSURL URLWithString:_newestModel.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    //是否是新主播
    self.anchorStatus.hidden = !_newestModel.newStar;
    //地址
    self.anchorAddress.text = _newestModel.position;
     //主播名
    self.anchorName.text = _newestModel.nickname;
}

@end
