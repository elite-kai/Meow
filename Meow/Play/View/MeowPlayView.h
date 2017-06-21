//
//  MeowPlayView.h
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "UIImageView+WebCache.h"
#import <Accelerate/Accelerate.h>

typedef void(^MoviePlayBackStateDidChange)();

@class MeowAnchorModel;
@interface MeowPlayView : UIView


@property (nonatomic, strong) MeowAnchorModel *model;

- (id)initWithFrame:(CGRect)frame withModel:(MeowAnchorModel *)model;

@property (nonatomic, copy) MoviePlayBackStateDidChange change;

@property (atomic, retain) id <IJKMediaPlayback> player;

@property (atomic, strong) NSURL *url;

//@property (nonatomic, strong)NSString * liveUrl;
//@property (nonatomic, strong)NSString * imageUrl;

@end
