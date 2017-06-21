//
//  NSArray+Log.m
//  Meow
//
//  Created by Parkin on 17/4/27.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    //开头有个[
    [string appendString:@"[\n"];
    //遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    //结尾有个]
    [string appendString:@"]"];
    //查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
}

@end
