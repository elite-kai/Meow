//
//  MeowCycleCell.m
//  Meow
//
//  Created by Parkin on 17/4/27.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowCycleCell.h"
#import "SDCycleScrollView.h"
#import "MeowADModel.h"

@interface MeowCycleCell ()<SDCycleScrollViewDelegate>

@end

@implementation MeowCycleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setModelArr:(NSArray *)modelArr
{
    
    _modelArr = modelArr;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (MeowADModel *ADModel in _modelArr) {
        [imageUrls addObject:ADModel.imageUrl];
    }
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.imageURLStringsGroup = imageUrls;
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(kScreenWidth, 160);
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    MeowADModel *ADModel = _modelArr[index];
    DESLog(@"---点击了第%@张图片", ADModel);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
