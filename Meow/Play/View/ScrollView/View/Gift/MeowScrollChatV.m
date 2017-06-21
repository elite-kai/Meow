//
//  MeowScrollChatV.m
//  Meow
//
//  Created by Parkin on 17/6/5.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowScrollChatV.h"

@interface MeowScrollChatV ()<UITableViewDataSource>


@end

@implementation MeowScrollChatV

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializa];
    }
    
    return self;
}

- (void)initializa
{
    _dataArray = [@[@"你好"] mutableCopy];
    _scrollChatTV = [[UITableView alloc] initWithFrame:self.bounds];
    _scrollChatTV.backgroundColor = [UIColor redColor];
    _scrollChatTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //最好不好调这个颜色
    _scrollChatTV.rowHeight = 50;
    _scrollChatTV.dataSource = self;
    [self addSubview:_scrollChatTV];

}

#pragma mark - TableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"row %@", _dataArray[indexPath.row]];
    
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
