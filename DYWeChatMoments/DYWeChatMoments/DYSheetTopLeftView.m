//
//  DYSheetTopLeftView.m
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import "DYSheetTopLeftView.h"

@interface DYSheetTopLeftView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DYSheetTopLeftView

- (instancetype)init {
    if (self = [super init]) {
        [self createMainView];
    }
    return self;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
}

- (void)createMainView {
    self.backgroundColor = DYColor(242, 244, 254, 1);
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
