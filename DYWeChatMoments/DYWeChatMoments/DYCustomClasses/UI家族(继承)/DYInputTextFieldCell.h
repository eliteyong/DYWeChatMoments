//
//  DYInputTextFieldCell.h
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//


//左边是label，右边是输入框
#import <UIKit/UIKit.h>
#import "DYTableViewHeader.h"

typedef void(^DYInputTextFieldBlock)(NSString *textFieldValue);

@interface DYInputTextFieldCell : UITableViewCell

+ (instancetype)dy_inputTextFieldCellForTableView:(UITableView *)tableView;

/**
 textField的回调
 */
@property (nonatomic, copy) DYInputTextFieldBlock textFieldBlock;

/**
 下划线的位置
 */
@property (nonatomic, assign) UITableViewCellLinePosition linePostion;
/**
 距离左右的距离
 */
@property (nonatomic, assign) CGFloat spaceToLeft;

/**
 左边的文字
 */
@property (nonatomic, strong) NSString *leftName;
/**
 左边字的颜色
 默认DYColorSame(51)
 */
@property (nonatomic, strong) UIColor *leftColor;
/**
 左边字体大小
 */
@property (nonatomic, strong) UIFont *leftFont;

/**
 右边textField的占位符
 */
@property (nonatomic, strong) NSString *rightPlacehoder;
/**
 右边textField的字体大小
 */
@property (nonatomic, strong) UIFont *rightTextFieldFont;
/**
 右边textField的字体颜色
 */
@property (nonatomic, strong) UIColor *rightTextColor;


@end
