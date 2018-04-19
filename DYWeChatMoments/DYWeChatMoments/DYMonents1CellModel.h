//
//  DYMonents1CellModel.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DYMonents1CellLikeItemModel, DYMonents1CellCommentItemModel;

@interface DYMonents1CellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *picNamesArray;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

/**
 关注数组
 */
@property (nonatomic, strong) NSArray<DYMonents1CellLikeItemModel *> *likeItemsArray;
/**
 评论数组
 */
@property (nonatomic, strong) NSArray<DYMonents1CellCommentItemModel *> *commentItemsArray;

/**
 是否展开
 */
@property (nonatomic, assign) BOOL isOpening;

/**
 是否需要显示更多按钮
 */
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end


//点赞关注的模型
@interface DYMonents1CellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end


//评论模型
@interface DYMonents1CellCommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end







