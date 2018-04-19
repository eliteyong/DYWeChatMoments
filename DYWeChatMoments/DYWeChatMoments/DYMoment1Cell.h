//
//  DYMoment1Cell.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMonents1CellModel.h"

@interface DYMoment1Cell : UITableViewCell

+ (instancetype)dy_moment1CellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) DYMonents1CellModel *moments1CellModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
