//
//  MeowHotVC.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowHotVC.h"
#import "MeowCarouselDetaVC.h"
#import "SDCycleScrollView.h"
#import "MeowHotVMClass.h"
#import "MeowHotCell.h"
#import "MeowCycleCell.h"
#import "SDCycleScrollView.h"

#import "MeowPlayBottV.h"
#import "MeowConcernVC.h"
#import "MeowPlayVC.h"


typedef NS_ENUM(NSInteger, FDSimulatedCacheMode) {
    FDSimulatedCacheModeNone = 0,
    FDSimulatedCacheModeCacheByIndexPath,
    FDSimulatedCacheModeCacheByKey
};


@interface MeowHotVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *hotTV;
@property (nonatomic, copy) NSMutableArray *hotModelArray;
//@property (nonatomic, copy) NSArray *imagesURLStrings;

@property (nonatomic, strong) MeowHotVMClass *hotVMClass;
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** 广告 */
@property(nonatomic, strong) NSArray *topADS;
//@property (nonatomic, strong) MeowHotVMClass *hotVMClass;


@end

@implementation MeowHotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    self.currentPage = 1;
    
    _hotVMClass = [[MeowHotVMClass alloc] init];
    
    [self getTopAD];
    
    [self getHotList];
    
    [self loadCustomView]; 
    
    [self refreshTV];
    

}

- (void)initializa
{
    
}

- (void)refreshTV
{
    // 下拉刷新
    _hotTV.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.currentPage = 1;
        //获取顶部的广告
        [self getTopAD];
        
        [self getHotList];
        // 结束刷新
        [_hotTV.mj_header endRefreshing];
    }];
    
    // 上拉刷新
    _hotTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getHotList];
        [_hotTV.mj_footer endRefreshing];
    }];
}

-(void)getTopAD{
    
    
    [_hotVMClass.ADSuccess subscribeNext:^(id  _Nullable x) {
        _topADS = x;
        [_hotTV reloadData];
        DESLog(@"topADS             %ld", _topADS.count);
    }];
    
    [_hotVMClass.ADError subscribeNext:^(id  _Nullable x) {
    }];
    
    //这个方法需要写在subscribeNext 的下面
    [_hotVMClass fetchCycleContent:self.currentPage];
//
    
}

- (void)getHotList
{
//    MeowHotVMClass *hotVMClass = [[MeowHotVMClass alloc] init];
    
    [_hotVMClass.hotSuccess subscribeNext:^(id  _Nullable x) {
        _hotModelArray = x;
        
        DESLog(@"_hotModelArray----------------%ld", _hotModelArray.count);
        [_hotTV reloadData];
    }];
    
    [_hotVMClass.hotError subscribeNext:^(id  _Nullable x) {
        self.currentPage--;
        
        // 结束刷新
        [_hotTV.mj_header endRefreshing];
        [_hotTV.mj_footer endRefreshing];
    }];
    
    //这个方法需要写在subscribeNext 的下面
    [_hotVMClass fetchHotContent:self.currentPage];
}

- (void)loadCustomView
{
    _hotTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-MeowTabBarHeight-MeowNavBarHeight)];
    _hotTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_hotTV registerNib:[UINib nibWithNibName:@"MeowCycleCell" bundle:nil] forCellReuseIdentifier:@"MeowCycleCell"];
    [_hotTV registerNib:[UINib nibWithNibName:@"MeowHotCell" bundle:nil] forCellReuseIdentifier:@"MeowHotCell"];
    _hotTV.delegate = self;
    _hotTV.dataSource = self;
    [self.view addSubview:_hotTV];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


#pragma mark - TableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _hotModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        MeowCycleCell *cycleCell = [tableView dequeueReusableCellWithIdentifier:@"MeowCycleCell" forIndexPath:indexPath];
        [self configureCycleCell:cycleCell atIndexPath:indexPath];
        return cycleCell;
    }else {
        MeowAnchorModel *model = _hotModelArray[indexPath.row];
        MeowHotCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"MeowHotCell" forIndexPath:indexPath];
        hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
        hotCell.hotModel = model;
        return hotCell;
    }

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        return [tableView fd_heightForCellWithIdentifier:@"MeowCycleCell" configuration:^(MeowCycleCell *cell) {
//            [self configureCycleCell:cell atIndexPath:indexPath];
//        }];
        return 100;
    }
    return [tableView fd_heightForCellWithIdentifier:@"MeowHotCell" configuration:^(MeowHotCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
        
    }];
}

- (void)configureCycleCell:(MeowCycleCell *)cycleCell atIndexPath:(NSIndexPath *)indexPath
{
    cycleCell.fd_enforceFrameLayout = YES;
    cycleCell.modelArr = _topADS;
}

- (void)configureCell:(MeowHotCell *)hotCell atIndexPath:(NSIndexPath *)indexPath
{
    hotCell.fd_enforceFrameLayout = YES;
    hotCell.hotModel = self.hotModelArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        
        MeowAnchorModel *model = _hotModelArray[indexPath.row];
        
        MeowPlayVC *playVC = [[MeowPlayVC alloc] init];
        playVC.modelArray = _hotModelArray;
        playVC.model = model;
        playVC.index = indexPath.row;
        [self presentViewController:playVC animated:YES completion:^{
            
        }];
        
    }

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
