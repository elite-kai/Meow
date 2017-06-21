//
//  WeowAudienceV.m
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowAudienceV.h"
#import "MeowAudienceCell.h"

#import "MeowAnchorModel.h"
#import "MeowNewestModel.h"

@interface MeowAudienceV ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *audienceCV;


@property (weak, nonatomic) IBOutlet UIView *anchorView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *peopleScrollView;

@property (weak, nonatomic) IBOutlet UIButton *giftView;

@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) NSMutableArray *chaoYangeUsers;

@end

@implementation MeowAudienceV

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


-(NSMutableArray *)chaoYangeUsers{
    if (!_chaoYangeUsers) {

//        _chaoYangeUsers = [MeowNewestModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _chaoYangeUsers;
}


- (void)initializa
{
    [self loadData];
    [self loadCollectionV];
}

- (void)loadData
{
    _chaoYangeUsers = [NSMutableArray array];
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user.plist" ofType:nil]];
    for (NSDictionary *dic in array) {
        MeowNewestModel *newestModel = [MeowNewestModel mj_objectWithKeyValues:dic];
        MeowAnchorModel *model = [[MeowAnchorModel alloc] init];
        model.bigpic = newestModel.photo;
        model.starlevel = newestModel.starlevel;
        model.myname = newestModel.nickname;
        model.smallpic = newestModel.photo;
        model.gps = newestModel.position;
        model.useridx = newestModel.useridx;
        model.flv = newestModel.flv;
        [_chaoYangeUsers addObject:model];
    }
}

- (void)loadCollectionV
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //horizontal 水平的， vertical 垂直的
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(45, 45);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _audienceCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    _audienceCV.delegate = self;
    _audienceCV.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"MeowAudienceCell" bundle:[NSBundle mainBundle]];
    [_audienceCV registerNib:nib forCellWithReuseIdentifier:@"MeowAudienceCell"];
    [self addSubview:_audienceCV];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _chaoYangeUsers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MeowAudienceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeowAudienceCell" forIndexPath:indexPath];
    MeowAnchorModel *model = _chaoYangeUsers[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DESLog(@"第%ld个观众", indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
