//
//  DYSheetLeftTableViewCell.m
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import "DYSheetLeftTableViewCell.h"

@interface DYSheetLeftTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DYSheetLeftTableViewCell

+ (instancetype)dy_sheetLeftTableViewCellForTableView:(UITableView *)tableView {
    DYSheetLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYSheetLeftTableViewCell"];
    if (cell == nil) {
        cell = [[DYSheetLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYSheetLeftTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.contentView.backgroundColor = bgColor;
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
    self.nameLabel = [UILabel labelWithFrame:CGRectZero text:@"" textColor:DYColorSame(153) font:DYFont(28)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.lineView = [UIView new];
    self.lineView.backgroundColor = DYColorSame(230);
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}

@end
