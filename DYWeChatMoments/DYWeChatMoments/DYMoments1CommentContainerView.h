//
//  DYMoments1CommentContainerView.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/20.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMonents1CellModel.h"

@interface DYMoments1CommentContainerView : UIView

@property (nonatomic, copy) void (^dy_moments1CommentClickBlock)(NSIndexPath *innerIndexPath, DYMonents1CellCommentItemModel *commentModel, CGRect rectInWindow);

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;



@end
