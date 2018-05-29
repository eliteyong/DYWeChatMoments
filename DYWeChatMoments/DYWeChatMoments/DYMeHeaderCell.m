//
//  DYMeHeaderCell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMeHeaderCell.h"

#define spaceToTop          12
#define iconImageWidth      64
#define spaceToLeft         13
#define QRWidth             16

@interface DYMeHeaderCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *QRCodeImageView;

@end

@implementation DYMeHeaderCell

+ (instancetype)dy_meHeaderCellForTableView:(UITableView *)tableView {
    DYMeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYMeHeaderCell"];
    if (cell == nil) {
        cell = [[DYMeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYMeHeaderCell"];
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
    self.iconImageView = [UIImageView imageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"xhr"]];
    self.nameLabel = [UILabel labelWithTextColor:DYColorSame(51) font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft];
    self.userNameLabel = [UILabel labelWithTextColor:DYColorSame(51) font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    self.QRCodeImageView = [UIImageView imageViewWithFrame:CGRectZero image:[UIImage imageNamed:@"qrcode"]];

    [self.contentView sd_addSubviews:@[self.iconImageView,self.nameLabel,self.userNameLabel,self.QRCodeImageView]];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, spaceToLeft)
    .topSpaceToView(self.contentView, spaceToTop)
    .widthIs(iconImageWidth)
    .heightEqualToWidth();
    self.iconImageView.sd_cornerRadius = @(3);
    
    self.QRCodeImageView.sd_layout
    .centerYEqualToView(self.iconImageView)
    .widthIs(QRWidth)
    .heightIs(QRWidth)
    .rightSpaceToView(self.contentView, 0);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView, 9 + spaceToTop)
    .leftSpaceToView(self.iconImageView, 10)
    .heightIs([UIFont systemFontOfSize:17].lineHeight)
    .rightSpaceToView(self.QRCodeImageView, 10);

    self.userNameLabel.sd_layout
    .topSpaceToView(self.nameLabel, 6)
    .leftSpaceToView(self.iconImageView, 10)
    .heightIs([UIFont systemFontOfSize:14].lineHeight)
    .rightSpaceToView(self.QRCodeImageView, 10);
    
    self.nameLabel.text = @"非洲平头哥";
    self.userNameLabel.text = @"微信号：HoneyBadger";
}

@end
