//
//  MeowGiftBarV.m
//  Meow
//
//  Created by Parkin on 17/5/17.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowGiftBarV.h"
#import "MeowGiftBarCell.h"
#import "MeowGiftFlowLayout.h"
#import "MeowGiftModel.h"

@interface CollectionCellWhite : UICollectionViewCell

@end

@implementation CollectionCellWhite

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface MeowGiftBarV ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *lastIndexPath;

@end

@implementation MeowGiftBarV

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

- (void)loadData
{
    _dataArray = [NSMutableArray array];
    
    for (int index = 0; index < 20; index++) {
        MeowGiftModel *model = [[MeowGiftModel alloc] init];
        model.imgUrl = @"红包";
        model.giftPrice = 30.0;
        model.giftCount = 1;
        model.giftName = [NSString stringWithFormat:@"红包%d", index];
        
        [_dataArray addObject:model];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_giftBarCV reloadData];
        });
    
    }
}

- (void)initializa
{

    [self loadData];
    
    MeowGiftFlowLayout *flowLayout = [[MeowGiftFlowLayout alloc] init];

    //水平滑动  Horizontal水平的
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.itemSize = CGSizeMake(kScreenWidth/4.0, kScreenWidth/4.0);
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    
    _giftBarCV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _giftBarCV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _giftBarCV.backgroundColor = [UIColor clearColor];
//    _giftBarCV.bounces = NO;
    _giftBarCV.pagingEnabled = YES;
    _giftBarCV.delegate = self;
    _giftBarCV.dataSource = self;
    
    [_giftBarCV registerClass:[CollectionCellWhite class] forCellWithReuseIdentifier:@"CellWhite"];
    UINib *nib = [UINib nibWithNibName:@"MeowGiftBarCell" bundle:[NSBundle mainBundle]];
    [_giftBarCV registerNib:nib forCellWithReuseIdentifier:@"MeowGiftBarCell"];
    
    [self addSubview:_giftBarCV];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_giftBarCV selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MeowGiftModel *model = _dataArray[indexPath.row];
//    DESLog(@"model: %@ count: %ld, row: %ld",model, model.giftCount, indexPath.row);
    if (indexPath.item >= 15) {
       CollectionCellWhite *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellWhite"
                                                                             forIndexPath:indexPath];
        return cell;
    }else {
        
        MeowGiftBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeowGiftBarCell"
                                                                          forIndexPath:indexPath];
        cell.model = model;

        /*需要手动调用一下，不然左右滑动collectionView的时候，
         由于cell的重用，model会变化，所以cell的值也跟着变化
         关键问题还是cell的重用问题
         */
        [cell setNeedsLayout];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeowGiftModel *model = _dataArray[indexPath.row];
    
    switch (model.giftCount) {
        case 1:
            [model setValue:@11 forKey:@"giftCount"];
            break;
        case 11:
            [model setValue:@66 forKey:@"giftCount"];
            break;
        case 66:
            [model setValue:@188 forKey:@"giftCount"];
            break;
        case 188:
            [model setValue:@520 forKey:@"giftCount"];
            break;
        case 520:
            [model setValue:@1314 forKey:@"giftCount"];
            break;
        case 1314:
            [model setValue:@9999 forKey:@"giftCount"];
            break;
        case 9999:
            [model setValue:@1 forKey:@"giftCount"];
            break;
        default:
            break;
    }
    
    if (self.lastIndexPath.row != indexPath.row) {
        [model setValue:@1 forKey:@"giftCount"];
    }
    
    MeowGiftBarCell *giftBarCell = (MeowGiftBarCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row != 0) {
         MeowGiftBarCell *oneCell = (MeowGiftBarCell *)[self collectionView:collectionView cellForItemAtIndexPath:self.lastIndexPath];
        oneCell.selectedView.hidden = YES;
    }
    giftBarCell.model = model;

    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [_dataArray replaceObjectAtIndex:indexPath.row withObject:giftBarCell.model];


    if ([self.delegate respondsToSelector:@selector(didSelectedCell:)]) {
        [self.delegate didSelectedCell:giftBarCell.model];
    }
    
    
    self.lastIndexPath = indexPath;
    
}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//设置section边距（上，左，下，右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageIndex = [NSString stringWithFormat:@"%ld", pageIndex];
    
    
    DESLog(@"pageIndex   %ld", pageIndex);
    
}

- (MeowPlayScrollV *)scrollViewWithViewObj:(UIView *)viewObj
{
    
    for (UIView* next = [viewObj superview]; next; next =
         next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
//        NSLog(@"nextResponder--------%@", nextResponder);
        if ([nextResponder isKindOfClass:[MeowPlayScrollV
                                          class]]) {
            return (MeowPlayScrollV*)nextResponder;
        }
    }
    return nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
