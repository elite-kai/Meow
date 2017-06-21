//
//  MeowHotVMClass.h
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowBaseVMClass.h"

@class MeowAnchorModel;
@interface MeowHotVMClass : MeowBaseVMClass

@property (nonatomic, strong) RACSubject *hotSuccess;
@property (nonatomic, strong) RACSubject *hotFailure;
@property (nonatomic, strong) RACSubject *hotError;

@property (nonatomic, strong) RACSubject *ADSuccess;
@property (nonatomic, strong) RACSubject *ADFailure;
@property (nonatomic, strong) RACSubject *ADError;



- (void)fetchHotContent:(NSInteger)currentPage;

- (void)fetchCycleContent:(NSInteger)currentPage;

- (void)meowCarouselWithHotModel:(MeowAnchorModel *)hotModel withViewController:(UIViewController *)superController;

@end
