//
//  MeowPlayVC.m
//  Meow
//
//  Created by Parkin on 17/6/16.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowPlayVC.h"
#import "MeowPlayBottV.h"

@interface MeowPlayVC ()

@end

@implementation MeowPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MeowPlayBottV *meowPlayBottV = [[MeowPlayBottV alloc] initWithFrame:self.view.bounds withModelArr:_modelArray withModel:_model withRow:_index];
    [self.view addSubview:meowPlayBottV];
}

- (void)dealloc
{
    DESLog(@"MeowPlayVC      dealloc");
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
