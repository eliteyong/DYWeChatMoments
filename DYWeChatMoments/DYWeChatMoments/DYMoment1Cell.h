//
//  DYMoment1Cell.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMonents1CellModel.h"

typedef void(^DYMoment1Block)(NSIndexPath *currentIndexPath);

@protocol DYMomentsCellOperationDelegate <NSObject>

- (void)didClickLikeBtnInCell:(UITableViewCell *)cell;
- (void)didClickCommentBtnInCell:(UITableViewCell *)cell;

@end

@interface DYMoment1Cell : UITableViewCell

@property (nonatomic, weak) id<DYMomentsCellOperationDelegate> delegate;

// outerIndexPath最外层的朋友圈所在的cell;innerIndexPath内层的点击评论所在的indexPath;commentModel当前点击的内层数据模型
@property (nonatomic, copy) void (^clickedToCommentBlock)(NSIndexPath *outerIndexPath, NSIndexPath *innerIndexPath, DYMonents1CellCommentItemModel *innerCommentModel);

+ (instancetype)dy_moment1CellForTableView:(UITableView *)tableView;

@property (nonatomic, copy) DYMoment1Block moreBlock;

@property (nonatomic, strong) DYMonents1CellModel *moments1CellModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
