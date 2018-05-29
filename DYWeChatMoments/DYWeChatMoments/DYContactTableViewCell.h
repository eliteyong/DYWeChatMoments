//
//  DYContactTableViewCell.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/27.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYContactInfoModel.h"

@interface DYContactTableViewCell : UITableViewCell

+ (instancetype)dy_contactTableViewCellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) DYContactInfoModel *model;

+ (CGFloat)fixedHeight;

@end
