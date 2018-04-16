//
//  UILabel+DYCustom.h
//  DYCustomClasses
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DYCustom)

/**
 快速创建一个label;字体大小、颜色
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

/**
 快速创建一个label;字体大小、颜色、对齐方式
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/**
 快速创建一个label;字体大小、颜色、对齐方式、背景颜色
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backgroudColor:(UIColor *)backgroundColor;

/**
 快速创建一个label，位置，文字，颜色，字体大小
 */
+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

/**
 快速创建一个label，位置，文字，颜色，字体大小，对齐方式，背景颜色
 */
+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backgroudColor:(UIColor *)backgroundColor;

/**
 自定义行间距；行间距，文字，字体
 */
- (void)setCustomLineSpacing:(CGFloat)lineSpacing withText:(NSString *)text font:(UIFont *)font;

/**
 计算UILabel上某段文字的frame
 */
- (CGRect)boundingRectForCharacterRange:(NSRange)range;

/**
 * !!!!!!! 注意：此方法是对SDAutoLayout的补充，使用此方法需使用SDAutoLayout自动布局
 * 设置label根据单行文字自适应
 * hPadding：左右边距
 */
- (void)setupAutoSizeWithHorizontalPadding:(CGFloat)hPadding labelHeight:(CGFloat)labelHeight;


@end
