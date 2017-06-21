//
//  MeowMineVC.m
//  Meow
//
//  Created by Parkin on 17/4/25.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowMineVC.h"
#import "UIScrollView+HeaderScaleImage.h"

@interface MeowMineVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mineTV;
@property (nonatomic, strong) UIButton *button;

@end

@implementation MeowMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadCustomView];
}


- (void)loadData
{
    
}

- (void)loadCustomView
{
    
    _mineTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeight)];
    //        _tableView.bounces = NO;
    _mineTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mineTV.backgroundColor = [UIColor grayColor];
    _mineTV.rowHeight = 90;
    _mineTV.delegate = self;
    _mineTV.dataSource = self;
    [self.view addSubview:_mineTV];
    
    
    // 设置tableView头部缩放图片 *一行代码就集成了*
    self.mineTV.yz_headerScaleImage = [UIImage imageNamed:@"header.jpg"];
    // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 30, 100, 100)];
    _button.backgroundColor = [UIColor redColor];
    _button.titleLabel.text = @"Test";
    [self.view addSubview:_button];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    // 清空头部视图背景颜色
    headerView.backgroundColor = [UIColor clearColor];
    self.mineTV.tableHeaderView = headerView;

}

#pragma mark - TableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"row %ld", indexPath.row];
    //    NSDictionary *prizeInfoDic = _goodsInfoArray[indexPath.row];
    //
    //    [cell cellWithDataDic:prizeInfoDic];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //    //拿到我们的LitterLCenterViewController，让它去push
    //    BaseNavViewController *nav = (BaseNavViewController*)self.mm_drawerController.centerViewController;
    //    [nav pushViewController:showVC animated:NO];
    //当我们push成功之后，关闭我们的抽屉
    //    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
    //        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
    //        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    //    }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DESLog(@"scrollView.y**************  %f", scrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) return;
//    _button.frame = CGRectMake(100, 30-offsetY, 100, 100);
    _button.top = 30-offsetY;
    
    
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        DetailedTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        [cell deletePrizeInfo:cell.deleteButton];
//    }
//
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}


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
