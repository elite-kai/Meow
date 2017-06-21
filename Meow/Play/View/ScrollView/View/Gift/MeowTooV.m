//
//  MeowTooV.m
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowTooV.h"

@implementation MeowTooV

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

- (IBAction)chatKeyboard:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(chatKeyboard:)]) {
        [self.delegate chatKeyboard:[@"键盘" mutableCopy]];
    }
}

- (IBAction)sharingPlatform:(UIButton *)sender {
}

- (IBAction)contributionList:(UIButton *)sender {
}

- (IBAction)giftBarView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(giftBarView:)]) {
        [self.delegate giftBarView:[@"礼物" mutableCopy]];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
