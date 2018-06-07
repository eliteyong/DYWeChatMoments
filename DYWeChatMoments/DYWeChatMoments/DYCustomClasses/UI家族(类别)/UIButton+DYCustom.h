//
//  UIButton+DYCustom.h
//  DYCustomClasses
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DYCustom)


/**
 创建按钮添加点击事件
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action;

/**
 创建按钮 标题，字体，颜色，背景色，点击事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleLabelFont:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action;

/**
 创建按钮 frame，标题，字体，颜色，背景色，点击事件
 */
+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title titleLabelFont:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action;

/**
 创建按钮 frame，图片，选中图片
 */
+ (instancetype)buttonWithFrame:(CGRect)frame image:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;


/**
 设置左边文字右边图片，space间隔
 */
- (void)setLeftTitleRightImageWithSpace:(CGFloat)space;

@end
