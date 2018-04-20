//
//  DYMonets1CommentCell.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/20.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMonents1CellModel.h"

typedef void(^DYMonets1CommentBlock)(NSIndexPath *innerIndexPath,DYMonents1CellCommentItemModel *commentModel);

@interface DYMonets1CommentCell : UITableViewCell

@property (nonatomic, copy) DYMonets1CommentBlock clickedCellBlock;

@property (nonatomic, strong) DYMonents1CellCommentItemModel *commentModel;

+ (instancetype)dy_monets1CommentCellForTableView:(UITableView *)tableView;

@end
