//
//  MeowPlayView.m
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowPlayView.h"
#import "MeowAnchorModel.h"


#define XJScreenH [UIScreen mainScreen].bounds.size.height
#define XJScreenW [UIScreen mainScreen].bounds.size.width

@interface MeowPlayView ()

@property (nonatomic, assign)int number;

@property (nonatomic, assign)CGFloat heartSize;

@property (nonatomic, strong)UIImageView *dimIamge;

@property (nonatomic, strong) NSArray *fireworksArray;

@property (nonatomic, weak) CALayer *fireworksL;

@end

@implementation MeowPlayView

- (id)initWithFrame:(CGRect)frame withModel:(MeowAnchorModel *)model
{
    if (self = [super initWithFrame:frame]) {
        _model = model;
        
        [self initializa];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initializa];
}

- (void)initializa
{

    // 播放视频
    [self goPlaying];
    
    // 开启通知
    [self installMovieNotificationObservers];
    
    // 设置加载视图
    [self setupLoadingView];
    
    // 创建按钮
    [self setupBtn];
}


#pragma mark ---- <设置加载视图>
- (void)setupLoadingView
{
//    self.dimIamge = [[UIImageView alloc] initWithFrame:self.bounds];
//    [_dimIamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@", self.model.portrait]] placeholderImage:[UIImage imageNamed:@"default_room"]];
//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    visualEffectView.frame = _dimIamge.bounds;
//    [_dimIamge addSubview:visualEffectView];
//    [self addSubview:_dimIamge];
    
}

#pragma mark ---- <创建按钮>
- (void)setupBtn {
    

    
}


- (void)goPlaying {
    DESLog(@"goPlaying================================");
    DESLog(@"self.model----------------------%@",self.model);
    //获取url
    self.url = [NSURL URLWithString:self.model.flv];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    _player.view.frame = self.bounds;
    [self addSubview:_player.view];
    
    // 设置 横屏时自动伸缩
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.player prepareToPlay];
    if (![self.player isPlaying]) {
        //准备播放
        [self.player prepareToPlay];
    }
    [self.player play];
    
//    // 自动调整自己的宽度和高度
//    playerview.frame = self.PlayerView.bounds;
//    playerview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    [self.PlayerView insertSubview:playerview atIndex:1];
//    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
}


// 暂停开始
- (void)play_btn:(UIButton *)sender {
    
    sender.selected =! sender.selected;
    if (![self.player isPlaying]) {
        // 播放
        [self.player play];
    }else{
        // 暂停
        [self.player pause];
    }
}


static int _fishIndex = 0;

- (void)update {
    
    _fishIndex++;
    
    if (_fishIndex > 1) {
        _fishIndex = 0;
    }
    UIImage *image = self.fireworksArray[_fishIndex];
    _fireworksL.contents = (id)image.CGImage;
}



#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}

#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        DESLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        DESLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        DESLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            DESLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            DESLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            DESLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            DESLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    DESLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
    _dimIamge.hidden = YES;
    
    if (self.change != nil) {
        self.change();
    }
    
    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            DESLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            DESLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            DESLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            DESLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            DESLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            DESLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

- (void)dealloc
{
    DESLog(@"MeowPlayView------------------------------- dealloc");

    [self.player shutdown];
    [self.player.view removeFromSuperview];
    self.player = nil;
    [self removeMovieNotificationObservers];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
