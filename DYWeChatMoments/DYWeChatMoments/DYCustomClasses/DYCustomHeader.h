//
//  DYCustomHeader.h
//  DYCustomClasses
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#ifndef DYCustomHeader_h
#define DYCustomHeader_h

#define DY_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DY_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define DYScreenHeight [UIScreen mainScreen].bounds.size.height
#define DYScreenWidth [UIScreen mainScreen].bounds.size.width

#define DYSCREEN_MAX_LENGTH (MAX(DYScreenWidth, DYScreenHeight))
#define DYSCREEN_MIN_LENGTH (MIN(DYScreenWidth, DYScreenHeight))

#define DY_IS_IPHONE4 (IS_IPHONE && DYSCREEN_MAX_LENGTH < 568.0)
#define DY_IS_IPHONE5 (IS_IPHONE && DYSCREEN_MAX_LENGTH == 568.0)
#define DY_IS_IPHONE6 (IS_IPHONE && DYSCREEN_MAX_LENGTH == 667.0)
#define DY_IS_IPHONE6P (IS_IPHONE && DYSCREEN_MAX_LENGTH == 736.0)
#define DY_iPhoneX (DYScreenWidth == 375.0f) && (DYScreenHeight == 812.0f) && DY_IS_IPHONE

#define DYAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define DYDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]

#define DYStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define DYSystemNavHeight 44.0
#define DYNavbarHeight (DYStatusBarHeight + DYSystemNavHeight)

#define DYTabBarHeight (DY_iPhoneX ? (49.f + 34.f) : (49.f))
#define DYBottomSafeHeight ((DY_iPhoneX) ? (34) : (0))

#define DYAlmostZero 0.0000001


#define DYColor(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define DYColorSame(r) [UIColor colorWithRed:r/255.0 green:r/255.0 blue:r/255.0 alpha:1]
#define DYColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]


#import "UILabel+DYCustom.h"
#import "UIButton+DYCustom.h"
#import "UIImageView+DYCustom.h"

#import "NSString+DYCustom.h"

#endif /* DYCustomHeader_h */
