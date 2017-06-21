//
//  MeowTabBa/Users/Liuminglu/Desktop/Meow/MeowrController.m
//  Meow
//
//  Created by Parkin on 17/4/25.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowTabBarController.h"
#import "MeowBaseNavController.h"
#import "MeowHomeVC.h"
//#import "MeowCameraVC.h"
#import "MeowMineVC.h"



@interface MeowTabBarController ()

@end

@implementation MeowTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MeowHomeVC *homeVC     = [[MeowHomeVC alloc] init];
//    MeowCameraVC *cameraVC = [[MeowCameraVC alloc] init];
    MeowMineVC *mineVC     = [[MeowMineVC alloc] init];
    MeowBaseNavController *homeNav = [[MeowBaseNavController alloc] initWithRootViewController:homeVC];
    [self addChildController:homeNav title:@"首页" imageName:@"Btn01" selectedImageName:@"SelectBtn01"];
    MeowBaseNavController *mineNav = [[MeowBaseNavController alloc]initWithRootViewController:mineVC];
    [self addChildController:mineNav title:@"我的" imageName:@"Btn02" selectedImageName:@"SelectBtn02"];
    [self addCenterController:nil bulge:YES title:nil imageName:@"post_normal" selectedImageName:@"bc"];
    
    
   
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
