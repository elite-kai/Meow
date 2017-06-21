//
//  MeowHotCell.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowHotCell.h"

@implementation MeowHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//@property (copy, nonatomic) NSString *ID;
//@property (copy, nonatomic) NSString *city;
//@property (copy, nonatomic) NSString *name;
//@property (copy, nonatomic) NSString *portrait;
//@property (copy, nonatomic) NSString *online_users;
//@property (copy, nonatomic) NSString *url;

- (void)setHotModel:(MeowAnchorModel *)hotModel
{
    _hotModel = hotModel;
    _nameLabel.text = _hotModel.myname;
    _shortNameLabel.text = _hotModel.myname;
    _watchCountLabel.text = [NSString stringWithFormat:@"%ld", _hotModel.allnum];
//    _statusLabel.text = _hotModel.status;
    _descLabel.text = [NSString stringWithFormat:@"%@开始直播啦", _hotModel.myname];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:_hotModel.smallpic]  placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    [_anchorPhotosImgView sd_setImageWithURL:[NSURL URLWithString:_hotModel.bigpic]  placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(kScreenWidth, 384);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
