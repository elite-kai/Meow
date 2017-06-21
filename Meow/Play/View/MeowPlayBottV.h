//
//  MeowPlayBottV.h
//  Meow
//
//  Created by Parkin on 17/5/2.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeowAnchorModel;
@interface MeowPlayBottV : UIView

- (instancetype)initWithFrame:(CGRect)frame
                 withModelArr:(NSMutableArray *)modelArr
                    withModel:(MeowAnchorModel *)model
                      withRow:(NSInteger)row;

@end
