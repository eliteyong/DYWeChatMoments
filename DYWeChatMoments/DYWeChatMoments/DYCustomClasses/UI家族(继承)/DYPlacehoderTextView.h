//
//  DYPlacehoderTextView.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

//带有placehoder的TextView，可以直接设置placehoder，以及placehoder的颜色

@interface DYPlacehoderTextView : UITextView

/*
 占位的label
 **/
@property (nonatomic, strong) UILabel *placeHolderLabel;

/*
 占位符
 **/
@property (nonatomic, copy) NSString *placeholder;

/*
 占位符颜色
 **/
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)textChanged:(NSNotification *)notification;

@end
