//
//  MeowPageControl.m
//  Meow
//
//  Created by Parkin on 17/5/18.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowPageControl.h"


@implementation MeowPageControl

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
    self.delegate = self;
    self.numberOfPages   = 5;
    self.dotImage        = [UIImage imageNamed:@"dotInactive"];
    self.currentDotImage = [UIImage imageNamed:@"dotActive"];
}

- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index
{
    
    self.currentPage = index;
    self.index = [NSString stringWithFormat:@"%ld", index];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
