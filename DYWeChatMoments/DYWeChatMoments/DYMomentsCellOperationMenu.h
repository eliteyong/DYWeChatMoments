//
//  DYMomentsCellOperationMenu.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMomentsCellOperationMenu : UIView

/**
 点击喜欢按钮
 */
@property (nonatomic, copy) void (^likeBtnClickBlock)();
/**
 点击评论按钮
 */
@property (nonatomic, copy) void (^commentBtnClickBlock)();

/**
 是否正在显示
 */
@property (nonatomic, assign, getter=isShowing) BOOL show;

@end
