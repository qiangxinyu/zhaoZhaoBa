//
//  Color.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef Color_h
#define Color_h

#define kRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1)]

#define kNavigationBarTextColor kRGB(22,179,191)

#define kDefaultBackgroudColor kRGB(238,238,238)

#define kWhiteColor [UIColor whiteColor]


#define kDefaultImage [UIImage imageNamed:@"占位图"]

#endif /* Color_h */
