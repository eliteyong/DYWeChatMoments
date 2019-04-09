//
//  DYSheetTopCollectionCell.m
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import "DYSheetTopCollectionCell.h"

@interface DYSheetTopCollectionCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation DYSheetTopCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createMainView];
    }
    return self;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
}
- (void)setNameColor:(UIColor *)nameColor {
    _nameColor = nameColor;
    self.nameLabel.textColor = nameColor;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.bgView.backgroundColor = bgColor;
    self.contentView.backgroundColor = bgColor;
}

- (void)createMainView {
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.nameLabel = [UILabel labelWithFrame:CGRectZero text:@"" textColor:DYColorSame(51) font:DYFont(28)];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    self.lineView = [UIView new];
//    [[UIView alloc] initWithFrame:CGRectMake(-1000, cellHeight - 1, cellWidth + 2000, 1)];
    self.lineView.backgroundColor = DYColorSame(230);
    [self.contentView addSubview:self.lineView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-1000);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(1000);
    }];
}

@end
