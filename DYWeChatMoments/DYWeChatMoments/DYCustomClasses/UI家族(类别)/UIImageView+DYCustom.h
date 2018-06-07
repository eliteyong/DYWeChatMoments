//
//  UIImageView+DYCustom.h
//  DYCustomClasses
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DYCustom)


/**
 创建imageView
 */
+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image backgroundColor:(UIColor *)backgroundColor;
+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/**
 创建圆角半径为cornersSize的imageView
 */
+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image backgroundColor:(UIColor *)backgroundColor roundedCornersSize:(CGFloat)cornersSize;


/**
 imageView通过Graphics和BezierPath设置圆角
 
 @param cornersSize 圆角半径
 */
- (void)setGraphicsCutCircularWithRoundedCornersSize:(CGFloat)cornersSize;

@end
