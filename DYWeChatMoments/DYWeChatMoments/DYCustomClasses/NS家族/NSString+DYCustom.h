//
//  NSString+DYCustom.h
//  DYCustomClasses
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DYCustom)

/**
 通过宽度和字体大小自适应Size
 */
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;

/**
 通过高度和字体大小自适应Size
 */
- (CGSize)sizeWithLabelHeight:(CGFloat)height font:(UIFont *)font;

/**
 通过宽度和字体大小自适应高度
 */
- (CGFloat)heightWithLabelWidth:(CGFloat)width font:(UIFont *)font;

/**
 通过高度和字体大小自适应宽度
 */
- (CGFloat)widthWithLabelHeight:(CGFloat)height font:(UIFont *)font;

/*
 根据内容，Label字体大小、行间距、宽度，来获取字体高度
 **/
- (CGFloat)getLabelHeightWithFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width;


@end
