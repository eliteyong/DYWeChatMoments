//
//  DYMoment1Cell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMoment1Cell.h"
#import "DYComentsPhotoContainerView.h"


const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定


#define iconImageWidth              40
#define nameFont                    [UIFont systemFontOfSize:16]
#define nameColor                   DYColor(54, 71, 121, 1)
#define contentFont                 [UIFont systemFontOfSize:15]
#define contentColor                DYColorSame(51)
#define moreBtnColor                DYColor(82, 140, 193, 1)
#define moreBtnFont                 [UIFont systemFontOfSize:14]
#define timeColor                   [UIColor lightGrayColor]
#define timeFont                    [UIFont systemFontOfSize:13]

@interface DYMoment1Cell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) DYComentsPhotoContainerView *photoContainerView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *operationBtn;

@end

@implementation DYMoment1Cell

+ (instancetype)dy_moment1CellForTableView:(UITableView *)tableView {
    DYMoment1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYMoment1Cell"];
    if (cell == nil) {
        cell = [[DYMoment1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYMoment1Cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)moreBtnClick {

}

- (void)operationBtnClick {

}

- (void)createMainView {
    self.iconImageView = [UIImageView imageViewWithFrame:CGRectZero image:nil];
    self.nameLabel = [UILabel labelWithTextColor:nameColor font:nameFont];
    self.contentLabel = [UILabel labelWithTextColor:contentColor font:[UIFont systemFontOfSize:contentLabelFontSize]];
    self.contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = self.contentLabel.font.lineHeight * 3;
    }
    //全文
    self.moreBtn = [UIButton buttonWithTitle:@"" titleLabelFont:moreBtnFont titleColor:moreBtnColor backgroundColor:nil target:self action:@selector(moreBtnClick)];
    self.operationBtn = [UIButton buttonWithFrame:CGRectZero image:[UIImage imageNamed:@"AlbumOperateMore"] selectedImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] target:self action:@selector(operationBtnClick)];
    self.timeLabel = [UILabel labelWithTextColor:timeColor font:timeFont];
    
    self.photoContainerView = [[DYComentsPhotoContainerView alloc] init];
    
    [self.contentView sd_addSubviews:@[self.iconImageView,self.nameLabel,self.contentLabel,self.photoContainerView,self.moreBtn,self.operationBtn,self.timeLabel]];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    self.iconImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .widthIs(iconImageWidth)
    .heightIs(iconImageWidth);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, margin)
    .topEqualToView(self.iconImageView)
    .heightIs(nameFont.lineHeight);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:DYScreenWidth - 3 * margin - iconImageWidth];
    
    self.contentLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .topSpaceToView(self.nameLabel, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    //高度在setModel里面设置；同样距离contenLabel的高度可以是0也可以是margin，得在setModel里面判断
    self.moreBtn.sd_layout
    .leftEqualToView(self.contentLabel)
    .topSpaceToView(self.contentLabel, margin)
    .widthIs(30);
    
    //宽度和
    self.photoContainerView.sd_layout
    .leftEqualToView(self.contentLabel);
}


@end
