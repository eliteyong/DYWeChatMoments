//
//  DYDiscoverListCell.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYDiscoverListCell : UITableViewCell

+ (instancetype)dy_discoverListCellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, assign) BOOL isHiddenLine;

@end
