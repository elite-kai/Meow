//
//  MeowPlayScrollV.m
//  Meow
//
//  Created by Parkin on 17/5/10.
//  Copyright © 2017年 Parkin. All rights reserved.
//


#import "MeowPlayScrollV.h"
#import "MeowAnchorReV.h"
#import "MeowAudienceV.h"
#import "MeowTooV.h"
#import "MeowGiftV.h"
#import "MeowPlayCell.h"
#import "MeowScrollChatV.h"
#import "MeowPlayView.h"
#import "MeowAnchorModel.h"

#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"

//MeowGiftVH 的高度
//static CGFloat const MeowGiftVH = 257;
#define MeowGiftVH   (78.0+kScreenWidth/2.0)

@interface MeowPlayScrollV ()<MeowTooVDelegate, ChatKeyBoardDelegate, ChatKeyBoardDataSource>
{
    MeowGiftV *_meowGiftV;
}


@property (nonatomic, strong) MeowScrollChatV *scrollChatV;
/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

@end

@implementation MeowPlayScrollV

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
    self.backgroundColor = [UIColor clearColor];
    //默认显示第二页，要放在contentSize这个方法的上边，不然不起作用
    self.contentOffset = CGPointMake(kScreenWidth, kScreenHeight);
    self.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    //是否整夜翻动
    self.pagingEnabled = YES;
    //指定控件是否只能在一个方向上滚动
    self.directionalLockEnabled = YES;
    //控制是否反弹
    self.bounces = NO;
    
//    //视频
//    MeowPlayView *playView = [[MeowPlayView alloc] initWithFrame:self.bounds withModel:self.model];
//    [self addSubview:playView];
    
    //主播信息
    MeowAnchorReV *meowAnV = [[[NSBundle mainBundle] loadNibNamed:@"MeowAnchorReV" owner:nil options:nil] lastObject];
    meowAnV.frame = CGRectMake(20+kScreenWidth, 60, 170, 65);
    meowAnV.anchorModel = _model;
    [self addSubview:meowAnV];
    
    //观众
    MeowAudienceV *meowAuV = [[MeowAudienceV alloc] initWithFrame:CGRectMake(meowAnV.right+20, 60, kScreenWidth-(meowAnV.width+20+20), 65)];
    
    [self addSubview:meowAuV];
    
    //最下方的工具，键盘，分享，礼物
    MeowTooV *meowTooV = [[[NSBundle mainBundle] loadNibNamed:@"MeowTooV" owner:nil options:nil] lastObject];
    meowTooV.frame = CGRectMake(kScreenWidth, kScreenHeight-50, kScreenWidth, 50);
    meowTooV.delegate = self;
    [self addSubview:meowTooV];
    
    //显示聊天的界面
    _scrollChatV = [[MeowScrollChatV alloc] initWithFrame:CGRectMake(kScreenWidth, meowTooV.top-200, kScreenWidth*0.75, 200)];
    _scrollChatV.backgroundColor = [UIColor blackColor];
    [self addSubview:_scrollChatV];
    
    //礼物栏view
    //    CGFloat giftVH = 60.0+kScreenWidth/2.0;
    _meowGiftV = [[[NSBundle mainBundle] loadNibNamed:@"MeowGiftV" owner:nil options:nil] lastObject];
    _meowGiftV.frame = CGRectMake(kScreenWidth, kScreenHeight, kScreenWidth, MeowGiftVH);
    [self addSubview:_meowGiftV];
    
    //监听键盘高度改变
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playScrollViewMove:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
}

- (void)objectsFallGest
{
    [UIView animateWithDuration:0.5 animations:^{
        _meowGiftV.frame = CGRectMake(kScreenWidth, kScreenHeight, kScreenWidth, MeowGiftVH);
    }];
}

//需要用下面的方法代理单击手势，不然左滑的时候会有问题，浪费了好久，坑爹呀
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:NSClassFromString(@"UIScrollView")]) {
        
        [self objectsFallGest];
    }
    if (self.chatKeyBoard) [self.chatKeyBoard removeFromSuperview];
}

- (void)chatKeyboard:(NSMutableString *)chatStr{
    
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    [self.chatKeyBoard keyboardUp];
    //    self.chatKeyBoard = [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    
    self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    
    self.chatKeyBoard.placeHolder = @"请输入消息，请输入消息，请输入消息，请输入消息，请输入消息，请输入消息，请输入消息，请输入消息";
    //将键盘添加到MeowPlayCell
    [self.superview.superview addSubview:self.chatKeyBoard];
    
}

- (void)sharingPlatform:(NSMutableString *)shareStr{}
- (void)contributionList:(NSMutableString *)contrStr{}
- (void)giftBarView:(NSMutableString *)giftStr
{
    [UIView animateWithDuration:0.5 animations:^{
        _meowGiftV.frame = CGRectMake(kScreenWidth, kScreenHeight-MeowGiftVH, kScreenWidth, MeowGiftVH);
    }];
}

- (void)playScrollViewMove:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    CGPoint keyboardOrign = [value CGRectValue].origin;
    
    DESLog(@"keyboardOrign  %@", NSStringFromCGPoint(keyboardOrign));
    //输入框位置动画加载
    [UIView animateWithDuration:duration animations:^{
        //do something
        self.bottom = keyboardOrign.y;
    }];
}

//- (void)removeYTKeyBoardView
//{
//    [self.chatKeyBoard removeFromSuperview];
//}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}


#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text
{
    if ([text isKindOfClass:[NSString class]]) {
        //        string = resous;
        [_scrollChatV.dataArray addObject:text];
        [_scrollChatV.scrollChatTV beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_scrollChatV.dataArray.count-1 inSection:0];
        [_scrollChatV.scrollChatTV insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_scrollChatV.scrollChatTV endUpdates];
        
        [_scrollChatV.scrollChatTV scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


//if ([resous isKindOfClass:[NSString class]]) {
//    //        string = resous;
//    [_scrollChatV.dataArray addObject:resous];
//    [_scrollChatV.scrollChatTV beginUpdates];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_scrollChatV.dataArray.count-1 inSection:0];
//    [_scrollChatV.scrollChatTV insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [_scrollChatV.scrollChatTV endUpdates];
//
//    [_scrollChatV.scrollChatTV scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}


- (MeowPlayCell *)meowPlayCellWithViewObj:(UIView *)viewObj
{
    for (UIView* next = [viewObj superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[MeowPlayCell
                                          class]]) {
            return (MeowPlayCell*)nextResponder;
        }
    }
    return nil;
}

- (void)dealloc
{
    [self.chatKeyBoard removeFromSuperview];
    self.chatKeyBoard = nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardDidHideNotification
//                                                  object:nil];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

