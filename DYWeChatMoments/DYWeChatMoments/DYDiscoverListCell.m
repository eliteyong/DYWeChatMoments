//
//  DYDiscoverListCell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDiscoverListCell.h"

@interface DYDiscoverListCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation DYDiscoverListCell

+ (instancetype)dy_discoverListCellForTableView:(UITableView *)tableView {
    DYDiscoverListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYDiscoverListCell"];
    if (cell == nil) {
        cell = [[DYDiscoverListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYDiscoverListCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createMainView];
    }
    return self;
}

- (void)createMainView {
    
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
//        _iconImageView = [UIImageView ]
    }
    return _iconImageView;
}


@end
