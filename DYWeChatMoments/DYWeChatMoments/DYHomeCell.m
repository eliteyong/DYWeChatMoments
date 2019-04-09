//
//  DYHomeCell.m
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import "DYHomeCell.h"

@interface DYHomeCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DYHomeCell

+ (instancetype)dy_homeCellForTableView:(UITableView *)tableView {
    DYHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYHomeCell"];
    if (cell == nil) {
        cell = [[DYHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYHomeCell"];
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

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
}
- (void)createMainView {
    self.nameLabel = [UILabel labelWithFrame:CGRectZero text:@"" textColor:DYColorSame(51) font:[UIFont systemFontOfSize:17]];
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = DYColorSame(238);
    [self.contentView addSubview:self.nameLabel];
//    [self.contentView addSubview:self.lineView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(13);
        make.bottom.mas_equalTo(0);
    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(1);
//        make.left.mas_equalTo(13);
//        make.bottom.mas_equalTo(0);
//        make.right.mas_equalTo(-13);
//    }];
}

@end
