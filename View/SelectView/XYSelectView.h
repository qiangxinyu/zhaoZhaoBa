//
//  XYNearDriverSchoolSelectView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYButton;
typedef void (^clickSelectView_block)(XYButton * btn);



//button 的 tag 起始值
static NSInteger buttonTag = 100000;

@interface XYSelectView : UIView
- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;


@property (nonatomic, copy)clickSelectView_block clickSelectView_block;
- (void)clickSelectView_blockWithBlock:(void(^)(XYButton * btn))clickSelectView_block;

/**
 *  按钮的 文字
 *
 *  @param array
 */
- (void)setArray:(NSArray *)array;

@end
