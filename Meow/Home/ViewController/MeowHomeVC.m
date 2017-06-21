//
//  MeowHomeVC.m
//  Meow
//
//  Created by Parkin on 17/4/25.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowHomeVC.h"
#import "MeowHotVC.h"
#import "MeowConcernVC.h"
#import "MeowNewestVC.h"


// 导航条高度
static CGFloat const BothSideW = 80;
@interface MeowHomeVC ()

@end

@implementation MeowHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    self.titleScrollViewBlock = ^(UIScrollView *titleScrollView) {
        titleScrollView.frame = CGRectMake(BothSideW, 0, kScreenWidth-2*BothSideW, 44);
    };
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        *titleScrollViewColor = RGB(194, 64, 234);
        *norColor = [UIColor blackColor];
        *selColor = [UIColor whiteColor];
        *titleWidth = (kScreenWidth-2*BothSideW) / 3;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        //        *isUnderLineDelayScroll = YES;
        *underLineColor = [UIColor whiteColor];
        *isUnderLineEqualTitleWidth = YES;
    }];
}


// 添加所有子控制器
- (void)setUpAllViewController
{
    MeowHotVC *hotVC = [[MeowHotVC alloc] init];
    hotVC.title = @"热门";
    [self addChildViewController:hotVC];
    
    MeowConcernVC *conVC = [[MeowConcernVC alloc] init];
    conVC.title = @"关注";
    [self addChildViewController:conVC];
    
    MeowNewestVC *newVC = [[MeowNewestVC alloc] init];
    newVC.title = @"最新";
    [self addChildViewController:newVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
