//
//  DYMomentsCellOperationMenu.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMomentsCellOperationMenu.h"

@interface DYMomentsCellOperationMenu ()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation DYMomentsCellOperationMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = DYColor(69, 74, 76, 1);
    
    self.likeBtn = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"AlbumLike"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
    self.commentBtn = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonClicked)];
    
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor grayColor];
    
    [self sd_addSubviews:@[self.likeBtn, self.commentBtn, centerLine]];
    
    CGFloat margin = 5;
    
    self.likeBtn.sd_layout
    .leftSpaceToView(self, margin)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(80);
    
    centerLine.sd_layout
    .leftSpaceToView(self.likeBtn, margin)
    .topSpaceToView(self, margin)
    .bottomSpaceToView(self, margin)
    .widthIs(1);
    
    self.commentBtn.sd_layout
    .leftSpaceToView(centerLine, margin)
    .topEqualToView(self.likeBtn)
    .bottomEqualToView(self.likeBtn)
    .widthRatioToView(self.likeBtn, 1);
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

- (void)likeButtonClicked {
    if (self.likeBtnClickBlock) {
        self.likeBtnClickBlock();
    }
    self.show = NO;
}

- (void)commentButtonClicked {
    if (self.commentBtnClickBlock) {
        self.commentBtnClickBlock();
    }
    self.show = NO;
}

- (void)setShow:(BOOL)show {
    _show = show;
    [UIView animateWithDuration:0.2 animations:^{
        if (!show) {
            [self clearAutoWidthSettings];
            self.sd_layout.widthIs(0);
        } else {
            self.fixedWidth = nil;
            [self setupAutoWidthWithRightView:self.commentBtn rightMargin:5];
        }
        // 更新cell内部的控件的布局（cell内部控件专属的更新约束方法,如果启用了cell frame缓存则会自动清除缓存再更新约束）
        [self updateLayoutWithCellContentView:self.superview];
    }];
}

@end
