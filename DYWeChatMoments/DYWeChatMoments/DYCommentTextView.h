//
//  DYCommentTextView.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

//评论框
@interface DYCommentTextView : UIView

@property (nonatomic, strong) DYPlacehoderTextView *textView;
/**
 提交按钮
 */
@property (nonatomic, strong) UIButton *submitBtn;

/**
 当前的高度
 */
@property (nonatomic, assign) CGFloat currentHeight;
/**
 记录上一次的高度
 */
@property (nonatomic, assign) CGFloat lastHeight;
/**
 行数
 */
@property (nonatomic, assign) NSInteger rows;

@end
