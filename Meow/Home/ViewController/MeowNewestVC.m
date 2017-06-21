//
//  MeowNewestVC.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowNewestVC.h"
#import "MeowNewestCell.h"
#import "MeowNewestVMClass.h"
#import "MeowAnchorModel.h"
#import "MeowPlayVC.h"

@interface MeowNewestVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *newestCV;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSMutableArray *anchorArray;

@property (nonatomic, strong) MeowNewestVMClass *newestVM;

@end

@implementation MeowNewestVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _newestVM = [[MeowNewestVMClass alloc] init];
    
    self.currentPage = 1;
    
    [self loadCustomView];
    
    [self getAnchorsList];
    
    [self refreshNewestCV];
    
}

- (void)refreshNewestCV
{
    //设置header和footer
    self.newestCV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.currentPage = 1;

        [self getAnchorsList];
        
    }];
    self.newestCV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getAnchorsList];

    }];
    
    [self.newestCV.mj_header beginRefreshing];
}

- (void)getAnchorsList
{
    
    [_newestVM.newestSuccess subscribeNext:^(id  _Nullable x) {
        
        [self.newestCV.mj_header endRefreshing];
        [self.newestCV.mj_footer endRefreshing];
        
        _anchorArray = x;
        [_newestCV reloadData];
    }];
    
    [_newestVM.newestError subscribeNext:^(id  _Nullable x) {
        [self.newestCV.mj_header endRefreshing];
        [self.newestCV.mj_footer endRefreshing];
        
        self.currentPage--;
    }];
    
    [_newestVM fetchNewestContent:self.currentPage];
}

- (void)loadCustomView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if(iPhone5 || iPhone6_plus){
        flowLayout.itemSize = CGSizeMake((kScreenWidth-2)/3.0, 160);
    }else {
        flowLayout.itemSize = CGSizeMake((kScreenWidth-3)/3.0, 160);
    }
    
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 1;
    
    _newestCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-MeowNavBarHeight-MeowTabBarHeight) collectionViewLayout:flowLayout];
    _newestCV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _newestCV.delegate = self;
    _newestCV.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"MeowNewestCell" bundle:nil];
    [_newestCV registerNib:nib forCellWithReuseIdentifier:@"MeowNewestCell"];
    [self.view addSubview:_newestCV];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _anchorArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeowNewestCell *newestCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeowNewestCell" forIndexPath:indexPath];
    MeowNewestModel *newestModel = _anchorArray[indexPath.row];
    newestCell.newestModel = newestModel;
    return newestCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSMutableArray *array = [NSMutableArray array];
    for (MeowNewestModel *newestModel in self.anchorArray) {
        MeowAnchorModel *hotModel = [[MeowAnchorModel alloc] init];
        hotModel.bigpic = newestModel.photo;
        hotModel.myname = newestModel.nickname;
        hotModel.smallpic = newestModel.photo;
        hotModel.gps = newestModel.position;
        hotModel.useridx = newestModel.useridx;
        hotModel.allnum = arc4random_uniform(2000);
        hotModel.flv = newestModel.flv;
        [array addObject:hotModel];
    }
    
    MeowPlayVC *playVC = [[MeowPlayVC alloc] init];
    playVC.modelArray = array;
    playVC.model = array[indexPath.row];
    playVC.index = indexPath.row;
    [self presentViewController:playVC animated:YES completion:^{
        
    }];
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
