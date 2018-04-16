//
//  DYCustomHeader.h
//  DYCustomClasses
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#ifndef DYCustomHeader_h
#define DYCustomHeader_h


#define DYColor(r,g,b,al)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define DYColorSame(r)            [UIColor colorWithRed:r/255.0 green:r/255.0 blue:r/255.0 alpha:1]
#define DYColorRGB(rgbValue)      [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]


#import "UILabel+DYCustom.h"
#import "UIButton+DYCustom.h"
#import "UIImageView+DYCustom.h"

#import "NSString+DYCustom.h"

#endif /* DYCustomHeader_h */
