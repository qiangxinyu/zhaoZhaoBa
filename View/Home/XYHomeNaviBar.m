//
//  XYHomeNaviBar.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeNaviBar.h"
#import "XYHomeViewController.h"


@implementation XYHomeNaviBar

+ (XYHomeNaviBar *)shareHomeNaviBar
{
    static XYHomeNaviBar * homeNaviBar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeNaviBar = [[XYHomeNaviBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBar_Height)];
        [homeNaviBar layoutViews];
    });
    return homeNaviBar;
}


static NSInteger messageBtn_width = 24;
static NSInteger messageBtn_height = 28;

static NSInteger saoBtn_width = 20;
static NSInteger soaBtn_height = 20;

//没有消息
static NSString * unMessageImageName = @"消息1";
//有消息了的 图片名字
static NSString * messageImageName = @"消息";
//扫一扫 图片名字
static NSString * saoImageName = @"扫一扫";

- (void)layoutViews
{
    self.backgroundColor = kWhiteColor;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self addSubview:view];
    
    self.cityBtn = [[XYButton alloc] initWithFrame:CGRectMake(0, 32, 60, 20)];
    [self addSubview:self.cityBtn];
    
    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame = CGRectMake(self.width - 5 - 24, 22 - messageBtn_height / 2 + 20, messageBtn_width, messageBtn_height);
    [self.messageBtn setImage:kImage(unMessageImageName) forState:UIControlStateNormal];
    [self.messageBtn addTarget:self action:@selector(clickMessageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageBtn];
    
    
    self.saoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saoBtn.frame = CGRectMake(self.messageBtn.frame.origin.x - saoBtn_width - 10, 22 - soaBtn_height / 2 + 20, saoBtn_width, soaBtn_height);
    [self.saoBtn setImage:kImage(saoImageName) forState:UIControlStateNormal];
    [self.saoBtn addTarget:self action:@selector(clickSaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.saoBtn];
    

    self.searchBar = [[XYSearchBar alloc] initWithFrame:CGRectMake(0, 20, self.width - (CGRectGetMaxX(self.cityBtn.frame) + 5) * 2, 30)];
    self.searchBar.center = CGPointMake(self.width / 2, 42);
    [self addSubview:self.searchBar];
    
    
    WeakSelf(weakSelf);
    XYHomeViewController * home = [XYHomeViewController shareHomeViewController];
    [self.searchBar setSearchBarBegainEdit:^(XYSearchBar *searchBar) {
        [home.view addSubview:weakSelf.backgourdView];
    }];

    [self.searchBar setSearchBarEndEdit:^(XYSearchBar *searchBar) {
        [weakSelf.backgourdView removeFromSuperview];
    }];
    
    
    [self.cityBtn clickCityBtn_block_xyButton:^(XYButton *view) {
        self.clickCityBtn_block ? self.clickCityBtn_block(self) : 0;
    }];
    
}

#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)clickMessageBtn_block:(void (^)(XYHomeNaviBar *))clickMessageBtn_block
{
    self.clickMessageBtn_block = clickMessageBtn_block;
}

- (void)clickSaoBtn_block:(void (^)(XYHomeNaviBar *))clickSaoBtn_block
{
    self.clickSaoBtn_block = clickSaoBtn_block;
}

- (void)clickCityBtn_block:(void (^)(XYHomeNaviBar *))clickCityBtn_block
{
    self.clickCityBtn_block = clickCityBtn_block;
}


#pragma mark -------------------------------------------------------
#pragma mark Click Method

- (void)clickMessageBtn
{
    self.clickMessageBtn_block ? self.clickMessageBtn_block(self) : 0;
}

- (void)clickSaoBtn
{
    self.clickSaoBtn_block ? self.clickSaoBtn_block(self) : 0;
}

#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYAddActionView *)backgourdView
{
    if (!_backgourdView) {
        _backgourdView = [[XYAddActionView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, kScreenHeight)];
        _backgourdView.backgroundColor = [UIColor blackColor];
        _backgourdView.alpha = .7;
        
        WeakSelf(weakSelf);

        [_backgourdView setClickView:^(UIView *view) {
            [weakSelf.searchBar.textField resignFirstResponder];
            [view removeFromSuperview];
        }];
    }
    return _backgourdView;
}


@end
