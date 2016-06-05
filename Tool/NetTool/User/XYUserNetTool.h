//
//  XYUserNetTool.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetTool.h"

NS_ASSUME_NONNULL_BEGIN
@interface XYUserNetTool : NSObject

/**
 *  注册 或者 登陆
 *
 *  @param phone          电话号码
 *  @param code           验证码
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)logingOrRegistWithPhone:(NSString *)phone
                           code:(NSString *)code
                      isRefresh:(BOOL)isRefresh
                 viewController:(XYRootViewController *)viewController
                        success:(nullable void (^)(NSDictionary * dic))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  发送验证码
 *
 *  @param phone          手机号
 *  @param isRefresh      是否刷新
 *  @param viewController 控制器
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)getCodeWithPhone:(NSString *)phone
               isRefresh:(BOOL)isRefresh
          viewController:(XYRootViewController *)viewController
                 success:(nullable void (^)())success
                 failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
NS_ASSUME_NONNULL_END