//
//  DYGlobal.m
//  DYCommenClasses
//
//  Created by admin on 17/6/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "DYGlobal.h"

@implementation DYGlobal
/**
 从像素px 转换为ios的 点阵pt
 */
+ (CGFloat)pxTopt:(CGFloat)px {
    
    CGFloat standardPt = px/2.0;
    standardPt = DYScreenWidth * standardPt / 375;
    
    return standardPt;
}

/**
 UIColor 转UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0,0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

/*
 根据传进来的数据适配不同屏幕
 **/
+ (CGFloat)fitWithWidth5:(CGFloat)width5 width6:(CGFloat)width6 widthPlus:(CGFloat)widthPlus {
  
//    if (DYScreenW == DYiphone5W) {
//
//        return width5;
//    } else if (DYScreenW == DYiphone6W) {
//
//        return width6;
//    } else if (DYScreenW == DYiphone6plusW) {
//
//        return widthPlus;
//    }
    
    return width5;
}

@end
