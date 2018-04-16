//
//  UIButton+DYCustom.m
//  DYCustomClasses
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "UIButton+DYCustom.h"

@implementation UIButton (DYCustom)

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (instancetype)buttonWithFrame:(CGRect)frame image:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *btn = [self buttonWithTarget:target action:action];

    btn.frame = frame;
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }

    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleLabelFont:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action {
    
    UIButton *btn = [self buttonWithTarget:target action:action];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        btn.titleLabel.font = font;
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }

    return btn;
}

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title titleLabelFont:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action {
    UIButton *btn = [self buttonWithTarget:target action:action];

    btn.frame = frame;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        btn.titleLabel.font = font;
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    
    return btn;
}

- (void)setLeftTitleRightImageWithSpace:(CGFloat)space {
    
    CGFloat btnImageWidth = self.imageView.bounds.size.width;
    CGFloat btnLabelWidth = self.titleLabel.bounds.size.width;
    CGFloat margin = space;
    
    btnImageWidth += margin;
    btnLabelWidth += margin;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - btnImageWidth, 0, btnImageWidth)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, btnLabelWidth, 0, - btnLabelWidth)];
}

@end
