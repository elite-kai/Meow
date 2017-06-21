//
//  MeowPlayBottV.m
//  Meow
//
//  Created by Parkin on 17/5/2.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowPlayBottV.h"
#import "MeowPlayCell.h"
#import "MeowPlayView.h"
#import "MeowAnchorModel.h"

@interface MeowPlayBottV ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) UITableView *meowLiveTV;
@property (nonatomic, assign) CGFloat endPos;

@property (nonatomic, assign) NSInteger row;

@end

@implementation MeowPlayBottV

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self initializa];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                 withModelArr:(NSMutableArray *)modelArr
                    withModel:(MeowAnchorModel *)model
                      withRow:(NSInteger)row
{
    if (self = [super initWithFrame:frame]) {
        
        _modelArr = modelArr;
        self.row = row;
        
        _meowLiveTV = [[UITableView alloc] initWithFrame:frame];
        _meowLiveTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _meowLiveTV.pagingEnabled = YES;
        _meowLiveTV.bounces = NO;
        _meowLiveTV.backgroundColor = [UIColor grayColor];
        _meowLiveTV.rowHeight = kScreenHeight;
        _meowLiveTV.delegate = self;
        _meowLiveTV.dataSource = self;
        [self addSubview:_meowLiveTV];
        
        
//        NSArray *indexPaths = [_meowLiveTV indexPathsForVisibleRows];
        
        [_meowLiveTV registerClass:[MeowPlayCell class] forCellReuseIdentifier:@"MeowPlayCell"];
        
        //初始化的时候点击的是哪个cell，就移动到点击的cell的位置
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [_meowLiveTV scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        MeowPlayCell *scrollPlayCell = (MeowPlayCell *)[self tableView:_meowLiveTV cellForRowAtIndexPath:scrollIndexPath];
        scrollPlayCell.model = model;
//        //代替KVO
//        [RACObserve(NSIndexPath, row) subscribeNext:^(id x) {
//            //        [self.player shutdown];
//            DESLog(@"model----------------------%@",x);
//            
//        }];
        //拖动手势
//        UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] init];
//        panGest.delegate = self;
//        [panGest addTarget:self action:@selector(panGestureRecognizer:)];
//        [_meowLiveTV addGestureRecognizer:panGest];
        
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initializa{}

#pragma mark - TableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MeowPlayCell";
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
    MeowPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"row %ld", indexPath.row];
    MeowAnchorModel *hotModel = _modelArr[indexPath.row];
    cell.imgStr = hotModel.bigpic;
//    cell.model = model;
    //UITableView中Cell重用机制导致内容重复解决方法
//    while ([cell.contentView.subviews lastObject] != nil)
//    {
//        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//    }
//
//    DESLog(@"Cell-------------------%@", cell);
//    //手动调用drawRect方法
//    [cell setNeedsDisplay];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:@"MeowPlayCell" configuration:^(MeowPlayCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
        
    }];
}


- (void)configureCell:(MeowPlayCell *)playCell atIndexPath:(NSIndexPath *)indexPath
{
    playCell.fd_enforceFrameLayout = YES;
//    playCell.hotModel = self.hotModelArray[indexPath.row];
}
#pragma mark - ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前的直播，并赋值开始直播
    NSInteger pageIndex = _meowLiveTV.contentOffset.y / CGRectGetHeight(_meowLiveTV.frame);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
    MeowPlayCell *playCell = [_meowLiveTV cellForRowAtIndexPath:indexPath];
    MeowAnchorModel *model = _modelArr[pageIndex];
    playCell.model = model;
    [playCell setNeedsDisplay];

    
    //获取滚动到上面的那个直播并关掉
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_row inSection:0];
    MeowPlayCell *lastPlayCell = (MeowPlayCell *)[self tableView:_meowLiveTV cellForRowAtIndexPath:lastPath];
    
    //UITableView中Cell重用机制导致内容重复解决方法，不然内存会一直增长
    while ([lastPlayCell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[lastPlayCell.contentView.subviews lastObject] removeFromSuperview];
    }

    //找到playView并且关掉直播
    for (UIView *subView in lastPlayCell.contentView.subviews) {
    
        if ([subView isKindOfClass:[MeowPlayView class]]) {
            
            MeowPlayView *playView = (MeowPlayView *)subView;
            
            [playView.player shutdown];
        }
    }
    
    //将这次的赋值，用给将要切换掉的主播
    _row = pageIndex;
    
//    DESLog(@"pageIndex -----------------  %ld", pageIndex);
}

//
//- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGest
//{
//    if (panGest.state == UIGestureRecognizerStateChanged) {
//        CGPoint point = [panGest translationInView:_meowLiveTV];
//        NSLog(@"point %@", NSStringFromCGPoint(point));
//    }
//    
//    if (panGest.state == UIGestureRecognizerStateEnded) {
//        
//        CGPoint point = [panGest translationInView:_meowLiveTV];
////        NSLog(@"point %@", NSStringFromCGPoint(point));
//        //向下拖动
//        if (point.y > kScreenHeight/5) {
//            
//            int toIndex = (int)(floorf(_endPos/kScreenHeight));
//            NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:toIndex inSection:0];
//            [_meowLiveTV scrollToRowAtIndexPath:toIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
//        }
//        //向上拖动
//        else if (point.y < -(kScreenHeight/5))
//        {
//            int toIndex = (int)(ceilf(_endPos/kScreenHeight));
////            NSLog(@"to index %d", toIndex);
//            NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:toIndex inSection:0];
//            [_meowLiveTV scrollToRowAtIndexPath:toIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
//        }
//    }
//    
//    
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]
//        || [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
//        return YES;
//    }
//    return NO;
//}
//
////记录拖动的位置
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    _endPos = scrollView.contentOffset.y;
//}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [self removeFromSuperview];
//    
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
