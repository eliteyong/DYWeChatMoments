//
//  DYGlobal.h
//  DYCommenClasses
//
//  Created by admin on 17/6/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#define DYFont(size)            [UIFont systemFontOfSize:[DYGlobal pxTopt:size]]
#define systemFont(size)        [UIFont systemFontOfSize:size]
#define DYFontI6EQ5(size)       (DYScreenWidth > 375 ? [UIFont systemFontOfSize:(size / 2.0)] : DYFont(size))


@interface DYGlobal : NSObject

/**
 从像素px转换为ios的点阵pt
 */
+ (CGFloat)pxTopt:(CGFloat)px;

/**
 UIColor 转UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/*
 根据不同的尺寸传入不同的数值，用来适配不同屏幕
 **/
+ (CGFloat)fitWithWidth5:(CGFloat)width5 width6:(CGFloat)width6 widthPlus:(CGFloat)widthPlus;


@end
