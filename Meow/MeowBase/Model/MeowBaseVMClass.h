//
//  MeowBaseVMClass.h
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#pragma - warning  用rac的话 继承于MeowBaseVMClass子类 需要重写init方法

#import <Foundation/Foundation.h>
//MeowBaseVMClass有子类了，如果没有引入 #import "ReactiveObjC.h"的话添加RACSubject会报错，原因尚不知道
#import "ReactiveObjC.h"


@interface MeowBaseVMClass : NSObject

//如果用rac的话就不用setBlockWithReturnBlock 这个方法
//@property (nonatomic, strong) RACSubject *successSubject;
//@property (nonatomic, strong) RACSubject *failureSubject;
//@property (nonatomic, strong) RACSubject *errorSubject;


//@property (nonatomic, copy) ReturnValueBlcok returnBlock;
//@property (nonatomic, copy) ErrorCodeBlock errorBlock;
//@property (nonatomic, copy) FailureBlock failureBlock;
//
//
// 传入交互的Block块
//-(void) setBlockWithReturnBlock: (ReturnValueBlcok) returnBlock
//                 WithErrorBlock: (ErrorCodeBlock) errorBlock
//               WithFailureBlock: (FailureBlock) failureBlock;


/**
 *  判断数组是否为空
 *
 *  @param array 数组
 *
 *  @return yes or no
 */
-(BOOL)isNotEmpty:(NSArray *)array;

@end
