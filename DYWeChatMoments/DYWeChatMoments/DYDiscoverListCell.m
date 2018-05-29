//
//  DYDiscoverListCell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDiscoverListCell.h"

#define spaceToLeft             16
#define iconImageWidth          23
#define cellHeight              44
#define labelLeftToImage        15

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

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    self.iconImageView.image = [UIImage imageNamed:dict.allValues.firstObject];
    self.nameLabel.text = dict.allKeys.firstObject;
}

- (void)setIsHiddenLine:(BOOL)isHiddenLine {
    _isHiddenLine = isHiddenLine;
    self.lineView.hidden = isHiddenLine;
}

- (void)createMainView {
    self.iconImageView = [UIImageView imageViewWithFrame:CGRectZero image:nil];
    self.nameLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17]];
    self.lineView = [UIView new];self.lineView.backgroundColor = DYColorSame(238);
    [self.contentView sd_addSubviews:@[self.iconImageView,self.nameLabel,self.lineView]];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, spaceToLeft)
    .widthIs(iconImageWidth)
    .heightIs(iconImageWidth)
    .yIs((cellHeight - iconImageWidth) / 2);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, labelLeftToImage)
    .topSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.contentView, spaceToLeft)
    .heightIs(1)
    .yIs(cellHeight - 1)
    .rightSpaceToView(self.contentView, - 110);
}

@end
