//
//  MeowConcernVC.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowConcernVC.h"
#import "MeowHotCell.h"


@interface MeowConcernVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *concernTV;

@end

@implementation MeowConcernVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self loadCustomView];
    
    [self refreshTV];
}

- (void)loadCustomView
{
    _concernTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-MeowTabBarHeight-MeowNavBarHeight)];
    _concernTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_concernTV registerNib:[UINib nibWithNibName:@"MeowHotCell" bundle:nil] forCellReuseIdentifier:@"MeowHotCell"];

    _concernTV.delegate = self;
    _concernTV.dataSource = self;
    [self.view addSubview:_concernTV];
}

- (void)refreshTV
{
    // 下拉刷新
    _concernTV.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [_concernTV.mj_header endRefreshing];
        });
    }];
    
    // 上拉刷新
    _concernTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [_concernTV.mj_footer endRefreshing];
        });
    }];
}


#pragma mark - TableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MeowHotCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"MeowHotCell" forIndexPath:indexPath];
    hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return hotCell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:@"MeowHotCell" configuration:^(MeowHotCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
        
    }];
}

- (void)configureCell:(MeowHotCell *)hotCell atIndexPath:(NSIndexPath *)indexPath
{
    hotCell.fd_enforceFrameLayout = YES;
//    hotCell.hotModel = self.hotModelArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
