//
//  UILabel+DYCustom.m
//  DYCustomClasses
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "UILabel+DYCustom.h"

@implementation UILabel (DYCustom)

+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [UILabel new];
    label.textColor = textColor;
    label.font = font;
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [self labelWithTextColor:textColor font:font];
    label.textAlignment = textAlignment;
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backgroudColor:(UIColor *)backgroundColor {
    UILabel *label = [self labelWithTextColor:textColor font:font];
    label.textAlignment = textAlignment;
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [self labelWithTextColor:textColor font:font];
    label.frame = frame;
    label.text = text;
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backgroudColor:(UIColor *)backgroundColor {
    UILabel *label = [self labelWithFrame:frame text:text textColor:textColor font:font];
    label.textAlignment = textAlignment;
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    return label;
}


// 通过段落样式设置UILabel的行间距
- (void)setCustomLineSpacing:(CGFloat)lineSpacing withText:(NSString *)text font:(UIFont *)font {
    NSMutableParagraphStyle *paraphStyle = [[NSMutableParagraphStyle alloc] init];
    paraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraphStyle.alignment = NSTextAlignmentLeft;
    paraphStyle.lineSpacing = lineSpacing;
    paraphStyle.hyphenationFactor = 1.0;
    paraphStyle.firstLineHeadIndent = 0.0;
    paraphStyle.paragraphSpacingBefore = 0.0;
    paraphStyle.headIndent = 0;
    paraphStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraphStyle};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    self.attributedText = attributeStr;
}
// 计算UILabel上某段文字的frame
- (CGRect)boundingRectForCharacterRange:(NSRange)range {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}
/**!!!!配合SDAutoLayout使用
 * 设置label根据单行文字自适应
 * hPadding：左右边距
 */
- (void)setupAutoSizeWithHorizontalPadding:(CGFloat)hPadding labelHeight:(CGFloat)labelHeight {
//    CGFloat width = [self.text widthWithLabelHeight:labelHeight font:self.font];
//    self.textAlignment = NSTextAlignmentCenter;
//    self.sd_layout.widthIs(width + 2 * hPadding);//需先导入SDAutoLayout
}

@end
