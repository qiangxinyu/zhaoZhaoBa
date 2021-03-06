//
//  XYAlbumViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAlbumViewController.h"
#import "XYAlbumCollectionViewCell.h"


@interface XYAlbumViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

{
    UICollectionView * _collectionView;
}
@property (nonatomic, strong)UILabel *countLabel;

@end



@implementation XYAlbumViewController


+ (XYAlbumViewController *)shareXYAlbumViewController
{
    static XYAlbumViewController * vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[XYAlbumViewController alloc] init];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.collectionView.contentOffset = CGPointMake(kScreenWidth * self.index, 0);
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)self.index,(unsigned long)self.groupArray.count];
}


#pragma mark -------------------------------------------------------
#pragma mark ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)index,(unsigned long)self.groupArray.count];
}



#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------Collection Delegate-------------------------------------
#pragma mark ----------------------------------------------------------------------


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYAlbumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    
    NSString * imageUrl;
    
    if ([self.groupArray[indexPath.row] isKindOfClass:NSString.class]) {
        imageUrl = self.groupArray[indexPath.row];
    } else if ([self.groupArray[indexPath.row] isKindOfClass:NSDictionary.class]) {
        imageUrl = self.groupArray[indexPath.row][@"pl_img"];

    }
    
    [cell.imageView setImageURL:[NSURL URLWithString:imageUrl]];
    
    WeakSelf(weakSelf);
    
    [cell getClickViewWithBlock:^{
        [UIView animateWithDuration:.4 animations:^{
            weakSelf.naviBar.mj_y = weakSelf.naviBar.mj_y == 0 ? -kNavigationBar_Height : 0;
        }];
        
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.width, collectionView.height);
}



#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,
                                                                            kNavigationBar_Height, kScreenWidth,
                                                                            kScreenHeight - kNavigationBar_Height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:XYAlbumCollectionViewCell.class forCellWithReuseIdentifier:@"a"];
    }
    return _collectionView;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 20)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = kWhiteColor;
        _countLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _countLabel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
