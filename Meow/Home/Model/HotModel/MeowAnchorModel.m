//
//  MeowAnchorModel.m
//  Meow
//
//  Created by Parkin on 17/4/26.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowAnchorModel.h"

@implementation MeowAnchorModel

-(UIImage *)starImage{
    if (self.starlevel) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19",self.starlevel]];
    }
    return nil;
}

@end
