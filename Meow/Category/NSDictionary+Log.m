//
//  NSDictionary+Log.m
//  DuobaoApp
//
//  Created by ios_kai on 16/10/14.
//  Copyright © 2016年 Europe and America Company. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    // 开头有个{
    [string appendString:@"{\n"];
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    return string;
}

@end
