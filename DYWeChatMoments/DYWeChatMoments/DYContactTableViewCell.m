//
//  DYContactTableViewCell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/27.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYContactTableViewCell.h"

@interface DYContactTableViewCell () {
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
}

@end

@implementation DYContactTableViewCell

+ (instancetype)dy_contactTableViewCellForTableView:(UITableView *)tableView {
    DYContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYContactTableViewCell"];
    if (cell == nil) {
        cell = [[DYContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYContactTableViewCell"];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 这行代是为了解决tableview开启了字母序列索引之后cell会向左缩进一段距离的问题
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        [self setupView];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame {
//    frame.size.width = 375;
//    [super setFrame:frame];
//}

- (void)setupView {
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    
    CGFloat margin = 10;
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView, margin)
    .widthIs(36)
    .heightEqualToWidth()
    .centerYEqualToView(self.contentView);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconImageView, margin)
    .centerYEqualToView(_iconImageView)
    .rightSpaceToView(self.contentView, margin)
    .heightIs(30);
    
}

- (void)setModel:(DYContactInfoModel *)model {
    _model = model;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.userName];
//    _iconImageView.image = [UIImage imageNamed:model.imageName];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"default_portrait"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

+ (CGFloat)fixedHeight {
    return 56;
}



@end
