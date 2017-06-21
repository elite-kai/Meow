//
//  MeowNewestModel.m
//  Meow
//
//  Created by Parkin on 17/4/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowNewestModel.h"

@implementation MeowNewestModel

//转模型的时候，属性名与系统名重名
//把属性名newStar转换成系统名new
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"newStar":@"new"};
    
}

@end
