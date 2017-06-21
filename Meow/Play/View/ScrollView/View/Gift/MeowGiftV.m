//
//  MeowGiftV.m
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowGiftV.h"
#import "MeowGiftBarV.h"
#import "MeowPageControl.h"
#import "MeowGiftModel.h"

@interface MeowGiftV ()<MeowGiftBarVDelegate>

@end

@implementation MeowGiftV

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)drawRect:(CGRect)rect{}

- (void)initializa
{
    
    
    self.giftInfoLabel.text = @"第一次默认";
    _giftBarV.frame = CGRectMake(0, 27, kScreenWidth, kScreenWidth/2.0);
    
    self.giftBarV.delegate = self;
    
    //观察者模式
    [self.giftBarV addObserver:self
               forKeyPath:@"pageIndex"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    [self.pageControl addObserver:self
                   forKeyPath:@"index"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
}



#pragma mark - MeowGiftBarVDelegate
- (void)didSelectedCell:(MeowGiftModel *)model
{
    self.giftInfoLabel.text = [NSString stringWithFormat:@"送了%ld个%@",model.giftCount, model.giftName];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{

    if ([keyPath isEqualToString:@"pageIndex"]) {
        self.pageControl.currentPage = [self.giftBarV.pageIndex integerValue];
    }
    else if ([keyPath isEqualToString:@"index"]) {
        self.giftBarV.pageIndex = [NSString stringWithFormat:@"%ld", self.pageControl.currentPage];
        
        [self.giftBarV.giftBarCV scrollRectToVisible:CGRectMake(kScreenWidth*self.pageControl.currentPage, self.giftBarV.giftBarCV.top, kScreenWidth, self.giftBarV.giftBarCV.height) animated:YES];
    }

}

- (void)dealloc
{
    [self.giftBarV removeObserver:self forKeyPath:@"pageIndex"];
    [self.pageControl removeObserver:self forKeyPath:@"index"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
