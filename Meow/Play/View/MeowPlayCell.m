//
//  MeowPlayCell.m
//  Meow
//
//  Created by Parkin on 17/5/2.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowPlayCell.h"
#import "MeowPlayScrollV.h"
#import "MeowPlayView.h"
#import "MeowPlayVC.h"

static CGFloat const CloseBtnW = 50.0;

@interface MeowPlayCell ()

@property (nonatomic, strong)UIImageView *dimIamge;

@end

@implementation MeowPlayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initializa];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initializa];
    }
    
    return self;
}

- (void)initializa
{
    [self setupLoadingView];
}

#pragma mark ---- <设置加载视图>
- (void)setupLoadingView
{
    _dimIamge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _dimIamge.backgroundColor = [UIColor redColor];
    [self addSubview:_dimIamge];
    
}

/*
 layoutSubviews调用机制
 
 ①、直接调用setLayoutSubviews。
 ②、addSubview的时候触发layoutSubviews。
 ③、当view的frame发生改变的时候触发layoutSubviews。
 ④、第一次滑动UIScrollView的时候触发layoutSubviews。
 ⑤、旋转Screen会触发父UIView上的layoutSubviews事件。
 ⑥、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件。
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    _dimIamge.hidden = NO;
    [_dimIamge sd_setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:[UIImage imageNamed:@"default_room"]];
    NSLog(@"layoutSubviews");

}

/*
 drawRect调用机制
 
 drawRect调用是在Controller->loadView,，Controller->viewDidLoad 两方法之后调用的。所以不用担心在控制器中，这些View的drawRect就开始画了。这样可以在控制器中设置一些值给View(如果这些View draw的时候需要用到某些变量值).
 
 1、如果在UIView初始化时没有设置rect大小，将直接导致drawRect不被自动调用。
 2、该方法在调用sizeThatFits后被调用，所以可以先调用sizeToFit计算出size。然后系统自动调用drawRect:方法。
 3、通过设置contentMode属性值为UIViewContentModeRedraw。那么将在每次设置或更改frame的时候自动调用drawRect:。
 4、直接调用setNeedsDisplay，或者setNeedsDisplayInRect:触发drawRect:，但是有个前提条件是rect不能为0.
 以上1,2推荐；而3,4不提倡
 */

//由于重用的原因，这个方法只调用两次

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

//    [RACObserve(self, model) subscribeNext:^(id  _Nullable x) {
//        
//    }];

    MeowPlayView *playView = [[MeowPlayView alloc] initWithFrame:self.bounds withModel:self.model];
    playView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:playView];
    playView.change = ^ {
        _dimIamge.hidden = YES;
    };
    
    MeowPlayScrollV *playScrollV = [[MeowPlayScrollV alloc] initWithFrame:self.bounds withModel:self.model];
    [self.contentView addSubview:playScrollV];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-CloseBtnW, kScreenHeight-CloseBtnW, CloseBtnW, CloseBtnW)];
    closeBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:closeBtn];

    
//    [closeBtn addTarget:self action:@selector(closeAnchor:) forControlEvents:UIControlEventTouchUpInside];
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        MeowPlayVC *playVC = (MeowPlayVC *)[self meowPlayVCWithViewObj:self];
        [playVC dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        [playView.player shutdown];
    }];
    
}

//- (void)closeAnchor:(UIButton *)button
//{
//    
//    MeowPlayBottV *playBottV = (MeowPlayBottV *)[self meowPlayBottVWithViewObj:self];
//    [playBottV removeFromSuperview];
//}


- (MeowPlayVC *)meowPlayVCWithViewObj:(UIView *)viewObj
{
    for (UIView* next = [viewObj superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[MeowPlayVC
                                          class]]) {
            return (MeowPlayVC*)nextResponder;
        }
    }
    return nil;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(kScreenWidth, kScreenHeight);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
