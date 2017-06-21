//
//  MeowHotVMClass.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowHotVMClass.h"
#import "MeowAnchorModel.h"
#import "MeowADModel.h"


@interface MeowHotVMClass ()

/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
/** 广告 */
//@property(nonatomic, strong) NSMutableArray *topADS;

@end

@implementation MeowHotVMClass


- (void)initialize {
    
    _hotSuccess = [RACSubject subject];
    _hotFailure = [RACSubject subject];
    _hotError = [RACSubject subject];
    
    _ADSuccess = [RACSubject subject];
    _ADFailure = [RACSubject subject];
    _ADError = [RACSubject subject];
}


- (id)init
{
    if (self = [super init]) {
        [self initialize];
        _lives = [NSMutableArray array];
        
    }
    
    return self;
}

//广告图
- (void)fetchCycleContent:(NSInteger)currentPage
{
    NSMutableArray *topADS = [NSMutableArray array];
    [LXNetworking getWithUrl:@"http://live.9158.com/Living/GetAD" params:nil success:^(id response) {
        for (NSDictionary *dataDic in response[@"data"]) {
            MeowADModel *model = [MeowADModel mj_objectWithKeyValues:dataDic];
            [topADS addObject:model];
        }
        
        [self.ADSuccess sendNext:topADS];
//        DESLog(@"response------------%@", response);
//        if ([self isNotEmpty:result]) {
//            self.topADS = [MeowADModel mj_objectArrayWithKeyValuesArray:result];
//            [self.successSubject sendNext:self.topADS];
//        }

    } fail:^(NSError *error) {
        
    } showHUD:NO];
}

//热门内容
- (void)fetchHotContent:(NSInteger)currentPage
{
    self.currentPage = currentPage;
    if (self.currentPage == 1) {
        [self.lives removeAllObjects];
    }
    
    [LXNetworking getWithUrl:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld", currentPage] params:nil success:^(id response) {
//        DESLog(@"response----------%@", response);
        for (NSDictionary *listDic in response[@"data"][@"list"]) {
            MeowAnchorModel *model = [MeowAnchorModel mj_objectWithKeyValues:listDic];
            [self.lives addObject:model];
        }
//        NSArray *result = [MeowAnchorModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
//        if ([self isNotEmpty:result]) {
//            [self.lives addObjectsFromArray:result];
//        }
        [self.hotSuccess sendNext:self.lives];
        
    } fail:^(NSError *error) {
        [self.hotError sendError:error];
    } showHUD:NO];
}

- (void)fetchValueSuccessWithDic:(id)returnValue
{
    
}

- (void)meowCarouselWithHotModel:(MeowAnchorModel *)hotModel withViewController:(UIViewController *)superController
{
    
}

-(BOOL)isNotEmpty:(NSArray *)array{
    
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return  YES;
    }
    
    return NO;
}

@end
