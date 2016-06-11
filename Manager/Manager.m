//
//  Manager.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Manager.h"

@implementation Manager

+ (Manager *)shareManager
{
    static Manager * manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[Manager alloc] init];
    });
    return manger;
}

- (void)createAlertOnceSureWithMessage:(NSString *)message title:(NSString *)title
{
    if (!title) {
        title = @"提示";
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

- (NSString *)getStringWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@",obj];
}
- (NSString *)getStringAddNumberWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@人已报名",obj];
}
- (NSString *)getStringAddKMWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@km",obj];
}

- (NSString *)getStringAddYuanWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@元",obj];
}

/**
 *  添加 XX年教龄
 *
 */
- (NSString *)getStringAddXXYearWithObj:(id)obj
{
    return [NSString stringWithFormat:@"%@年教龄",obj];
}

/**
 *  获取驾校排序类型
 */
- (NSString *)getDriverSchoolSortTypeWithChineseSortType:(NSString *)chinese
{
    if ([chinese isEqualToString:driver_school_sort_type_default]) {
        return DriverSchoolSortType_default;
    } else if ([chinese isEqualToString:driver_school_sort_type_price]) {
        return DriverSchoolSortType_price;
    } else if ([chinese isEqualToString:driver_school_sort_type_distance]) {
        return DriverSchoolSortType_distance;
    } else if ([chinese isEqualToString:driver_school_sort_type_sign_up_number]) {
        return DriverSchoolSortType_signnumber;
    } else if ([chinese isEqualToString:driver_school_sort_type_service]) {
        return DriverSchoolSortType_service;
    } else if ([chinese isEqualToString:driver_school_sort_type_car]) {
        return DriverSchoolSortType_car;
    } else if ([chinese isEqualToString:driver_school_sort_type_environment]) {
        return DriverSchoolSortType_environment;
    }
    return @"";
}

/**
 *  获取教练排序类型
 */
- (NSString *)getCoachSortTypeWithChineseSortType:(NSString *)chinese
{
    if ([chinese isEqualToString:coach_list_chinese_type_default]) {
        return coach_list_type_default;
    } else if ([chinese isEqualToString:coach_list_chinese_type_praisenumber]) {
        return coach_list_type_praisenumber;
    } else if ([chinese isEqualToString:coach_list_chinese_type_distance]) {
        return coach_list_type_distance;
    }
    return @"";
}

- (NSString *)getPraiseKeyWithStyle:(CommunityStyle)style
{
    switch (style) {
        case CommunityStyle_Default:        return community_communityid;     break;
        case CommunityStyle_DriverSchool:   return community_driver_school_id; break;
        case CommunityStyle_Coach:          return community_coach_id;     break;
    }
    return @"";
}


- (NSMutableDictionary *)addCellHeightWithDic:(NSDictionary *)dic key:(NSString *)key width:(NSInteger)width size:(NSInteger)size otherHeight:(NSInteger)otherHeight
{
    NSMutableDictionary * newDic = dic.mutableCopy;
    NSString * string = newDic[key];
    
    NSInteger height = [string boundingRectWithSize:CGSizeMake(width, 222222) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil].size.height;
    [newDic setValue:@(height + otherHeight) forKey:cell_height_key];
    return newDic;
    
}
- (NSMutableArray *)addCellHrightWithArray:(NSArray *)array key:(NSString *)key width:(NSInteger)width size:(NSInteger)size otherHeight:(NSInteger)otherHeight
{
    NSMutableArray * newArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        [newArray addObject:[self addCellHeightWithDic:dic key:key width:width size:size otherHeight:otherHeight]];
    }
    return newArray;
}
@end
