//
//  MeowNewestVMClass.h
//  Meow
//
//  Created by Parkin on 17/4/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowBaseVMClass.h"

#import "MeowNewestModel.h"
@interface MeowNewestVMClass : MeowBaseVMClass

@property (nonatomic, strong) RACSubject *newestSuccess;
@property (nonatomic, strong) RACSubject *newestFailure;
@property (nonatomic, strong) RACSubject *newestError;

- (void)fetchNewestContent:(NSInteger)currentPage;

- (void)meowCarouselWithNewestModel:(MeowNewestModel *)hotModel withViewController:(UIViewController *)superController;

@end
