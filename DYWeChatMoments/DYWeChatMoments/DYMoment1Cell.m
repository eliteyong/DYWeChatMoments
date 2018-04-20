//
//  DYMoment1Cell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMoment1Cell.h"
#import "DYComentsPhotoContainerView.h"
#import "DYMoments1CommentContainerView.h"

const CGFloat contentLabelFontSize = 16;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定


#define iconImageWidth              40
#define nameFont                    [UIFont systemFontOfSize:17]
#define nameColor                   DYColor(54, 71, 121, 1)
//#define contentFont                 [UIFont systemFontOfSize:15]
#define contentColor                DYColorSame(51)
#define moreBtnColor                DYColor(82, 140, 193, 1)
#define moreBtnFont                 [UIFont systemFontOfSize:16]
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

@property (nonatomic, strong) DYMoments1CommentContainerView *commentContainerView;

@property (nonatomic, strong) UIView *bottomLine;

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
    if (self.moreBlock) {
        self.moreBlock(self.indexPath);
    }
}

- (void)operationBtnClick {

}

- (void)setMoments1CellModel:(DYMonents1CellModel *)moments1CellModel {
    _moments1CellModel = moments1CellModel;
    
    CGFloat margin = 8;
    
    self.iconImageView.image = [UIImage imageNamed:moments1CellModel.iconName];
    self.nameLabel.text = moments1CellModel.name;
    self.contentLabel.text = moments1CellModel.msgContent;
    if (moments1CellModel.shouldShowMoreButton) { //如果文字总高度大于max
        self.moreBtn.sd_layout.heightIs(20).topSpaceToView(self.contentLabel, margin);
        self.moreBtn.hidden = NO;
        if (moments1CellModel.isOpening) { // 如果需要展开
            self.contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreBtn setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreBtn setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        self.moreBtn.sd_layout.heightIs(0).topSpaceToView(self.contentLabel, 0);
        self.moreBtn.hidden = YES;
    }
    
    //图片
    self.photoContainerView.picPathStringsArray = moments1CellModel.picNamesArray;
    CGFloat picContainerTopMargin = 0;
    if (moments1CellModel.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _photoContainerView.sd_layout.topSpaceToView(self.moreBtn, picContainerTopMargin);

    //评论框
    [self.commentContainerView setupWithLikeItemsArray:moments1CellModel.likeItemsArray commentItemsArray:moments1CellModel.commentItemsArray];
    CGFloat timeLabelTopMargin = 0;
    if (moments1CellModel.commentItemsArray.count > 0) {
        timeLabelTopMargin = 10;
    }
    self.timeLabel.sd_layout
    .topSpaceToView(self.commentContainerView, timeLabelTopMargin);
    
    [self setupAutoHeightWithBottomView:self.bottomLine bottomMargin:0];
    
    _timeLabel.text = @"1分钟前";
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
    self.commentContainerView = [[DYMoments1CommentContainerView alloc] init];
    
    self.bottomLine = [UIView new];self.bottomLine.backgroundColor = DYColorSame(238);
    
    [self.contentView sd_addSubviews:@[self.iconImageView,self.nameLabel,self.contentLabel,self.photoContainerView,self.moreBtn,self.operationBtn,self.timeLabel,self.commentContainerView,self.bottomLine]];
    
    __weak __typeof (self)weakSelf = self;
    self.commentContainerView.dy_moments1CommentClickBlock = ^(NSIndexPath *innerIndexPath, DYMonents1CellCommentItemModel *commentModel) {
        if (weakSelf.clickedToCommentBlock) {
            weakSelf.clickedToCommentBlock(weakSelf.indexPath, innerIndexPath, commentModel);
        }
    };
    
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
    .widthIs(35);
    
    //已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    self.photoContainerView.sd_layout
    .leftEqualToView(self.contentLabel);
    
    //已经在内部实现高度自适应所以不需要再设置高
    self.commentContainerView.sd_layout
    .leftEqualToView(self.contentLabel)
    .rightSpaceToView(contentView, margin)
    .topSpaceToView(self.photoContainerView, margin);
    
    self.timeLabel.sd_layout
    .leftEqualToView(self.contentLabel)
    .topSpaceToView(self.commentContainerView, margin)
    .heightIs(timeFont.lineHeight);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.operationBtn.sd_layout
    .rightSpaceToView(contentView, margin)
    .centerYEqualToView(_timeLabel)
    .heightIs(25)
    .widthIs(25);
    
    self.bottomLine.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(1)
    .topSpaceToView(self.timeLabel, margin *3 / 2);
    
}


@end
