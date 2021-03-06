//
//  XYCarShowOneTypeTableView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowOneTypeTableView.h"
#import "XYCarShowOneTypeTableViewCell.h"


@interface XYCarShowOneTypeTableView () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString * car_show_one_type_cell_key = @"car_show_one_type_cell_key d";

@implementation XYCarShowOneTypeTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = kDefaultBackgroudColor;
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"XYCarShowOneTypeTableViewCell" bundle:nil] forCellReuseIdentifier:car_show_one_type_cell_key];
        
        
    }
    return self;
}



#pragma mark -------------------------------------------------------
#pragma mark Mothod


- (void)getDidSelectItemWtihBlock:(DidSelectItemBlock)block
{
    self.didSelectItemBlock = block;
}

- (void)show
{
    self.isShow = YES;
}

- (void)hidden
{
    self.isShow = NO;
}

- (void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
    
    NSInteger x = kScreenWidth;
    if (isShow) {
        x =  kScreenWidth - self.width;
    }
    
    WeakSelf(weakSelf);
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        weakSelf.mj_x = x;
    }];
}

#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & dataSources



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupDic[car_show_list_key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.groupDic[car_show_typename];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCarShowOneTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:car_show_one_type_cell_key forIndexPath:indexPath];
    cell.myData = self.groupDic[car_show_list_key][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelectItemBlock ? self.didSelectItemBlock(self, self.groupDic[car_show_list_key][indexPath.row][car_show_type_list_ID] ,self.groupDic[car_show_typename]) : 0;
}


@end
