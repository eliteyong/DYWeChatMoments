//
//  DYSheetLeftTableViewCell.h
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYSheetLeftTableViewCell : UITableViewCell

+ (instancetype)dy_sheetLeftTableViewCellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *bgColor;

@end
