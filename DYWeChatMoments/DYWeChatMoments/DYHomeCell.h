//
//  DYHomeCell.h
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYHomeCell : UITableViewCell

+ (instancetype)dy_homeCellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSString *name;

@end
