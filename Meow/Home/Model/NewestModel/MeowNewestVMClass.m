//
//  MeowNewestVMClass.m
//  Meow
//
//  Created by Parkin on 17/4/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowNewestVMClass.h"

#import "MeowNewestModel.h"
@interface MeowNewestVMClass ()

/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;

/** 最新主播列表 */
@property(nonatomic, strong) NSMutableArray *anchors;

@end

@implementation MeowNewestVMClass

- (id)init
{
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    
    _anchors = [NSMutableArray array];
    _newestSuccess = [RACSubject subject];
    _newestFailure = [RACSubject subject];
    _newestError = [RACSubject subject];

}


- (void)fetchNewestContent:(NSInteger)currentPage
{
    self.currentPage = currentPage;
    if (self.currentPage == 1) {
        [self.anchors removeAllObjects];
    }
    [LXNetworking getWithUrl:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", self.currentPage] params:nil success:^(id response) {
        DESLog(@"response------------------------------%@", response);
//        [response[@"data"][@"list"] writeToFile:@"/Users/apple/Desktop/user.plist" atomically:YES];
        if ([self isNotEmpty:response[@"data"]]) {
            NSArray *result = response[@"data"][@"list"];
            for (NSDictionary *anchorsDic in result) {
                MeowNewestModel *model = [MeowNewestModel mj_objectWithKeyValues:anchorsDic];
                [self.anchors addObject:model];
            }
        }
        [self.newestSuccess sendNext:self.anchors];
//        if (result.count) {
//            [self.anchors addObjectsFromArray:result];
//        }
        
    
//        [self fetchValueSuccessWithDic:response];
    } fail:^(NSError *error) {
        [self.newestError sendError:error];
    } showHUD:NO];
    //    [self.successSubject sendNext:@"测试"];
}

- (void)fetchValueSuccessWithDic:(id)returnValue
{
    NSMutableArray *hotModelArray = [NSMutableArray array];
    for (NSDictionary *hotDic in returnValue) {
        MeowNewestModel *newestModel = [MeowNewestModel mj_objectWithKeyValues:hotDic];
        [hotModelArray addObject:newestModel];
    }
    
    //    self.returnBlock(hotModelArray);
    [self.newestSuccess sendNext:hotModelArray];
    
    
}


- (void)meowCarouselWithNewestModel:(MeowNewestModel *)hotModel withViewController:(UIViewController *)superController
{
    
}

-(BOOL)isNotEmpty:(NSDictionary *)dic{
    
    if ([dic isKindOfClass:[NSDictionary class]] && dic.count) {
        return  YES;
    }
    
    return NO;
}


@end
