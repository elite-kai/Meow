//
//  MeowBaseVMClass.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowBaseVMClass.h"

@implementation MeowBaseVMClass

//- (id)init
//{
//    if (self = [super init]) {
//        [self initialize];
//    }
//    
//    return self;
//}
//
//- (void)initialize {
//
//    _successSubject = [RACSubject subject];
//    _failureSubject = [RACSubject subject];
//    _errorSubject = [RACSubject subject];
//}

//如果用rac的话就不用setBlockWithReturnBlock 这个方法

//#pragma 接收传过来的block
//-(void) setBlockWithReturnBlock: (ReturnValueBlcok) returnBlock
//                 WithErrorBlock: (ErrorCodeBlock) errorBlock
//               WithFailureBlock: (FailureBlock) failureBlock
//{
//    _returnBlock = returnBlock;
//    _errorBlock = errorBlock;
//    _failureBlock = failureBlock;
//}
//


-(BOOL)isNotEmpty:(NSArray *)array{
    
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return  YES;
    }
    
    return NO;
}

@end
