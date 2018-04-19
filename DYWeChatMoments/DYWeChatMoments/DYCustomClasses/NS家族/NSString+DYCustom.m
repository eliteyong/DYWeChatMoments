//
//  NSString+DYCustom.m
//  DYCustomClasses
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "NSString+DYCustom.h"

@implementation NSString (DYCustom)

- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font {
    NSDictionary *dict = @{NSFontAttributeName : font};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin)attributes:dict context:nil];
    
    CGFloat sizeWidth = ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght = ceilf(CGRectGetHeight(rect));
    
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (CGSize)sizeWithLabelHeight:(CGFloat)height font:(UIFont *)font {
    NSDictionary *dict = @{NSFontAttributeName : font};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:(NSStringDrawingUsesLineFragmentOrigin)attributes:dict context:nil];
    
    CGFloat sizeWidth = ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght = ceilf(CGRectGetHeight(rect));
    
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (CGFloat)heightWithLabelWidth:(CGFloat)width font:(UIFont *)font {
    NSDictionary *dict = @{NSFontAttributeName : font};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin)attributes:dict context:nil];
    
    return rect.size.height;
}

- (CGFloat)widthWithLabelHeight:(CGFloat)height font:(UIFont *)font {
    NSDictionary *dict = @{NSFontAttributeName : font};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:(NSStringDrawingUsesLineFragmentOrigin)attributes:dict context:nil];
    
    return rect.size.width;
}


- (CGFloat)getLabelAutoHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width {
    CGFloat currentHeight = [self getLabelAutoHeightWithFont:font lineSpacing:lineSpacing width:width];
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行;如果只有一行那么就是返回一行的高度
    if (currentHeight - font.lineHeight <= lineSpacing) {
        currentHeight = currentHeight - lineSpacing;
    }
    
    return currentHeight;
}

- (CGFloat)getLabelHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
  
//    CGFloat currentHeight = size.height;
//    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行;如果只有一行那么就是返回一行的高度
//    if (currentHeight - font.lineHeight <= lineSpacing) {
//        currentHeight = currentHeight - lineSpacing;
//    }
    
    
    return size.height;
}

@end
