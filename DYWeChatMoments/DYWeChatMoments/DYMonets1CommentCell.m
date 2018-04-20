//
//  DYMonets1CommentCell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/20.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMonets1CommentCell.h"
#import "MLLinkLabel.h"

#define CommentCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]
@interface DYMonets1CommentCell () <MLLinkLabelDelegate>

@property (nonatomic, strong) MLLinkLabel *commentLabel;

@end

@implementation DYMonets1CommentCell

+ (instancetype)dy_monets1CommentCellForTableView:(UITableView *)tableView {
    DYMonets1CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYMonets1CommentCell"];
    if (cell == nil) {
        cell = [[DYMonets1CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYMonets1CommentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = DYColorSame(240);
        [self createMainView];
    }
    return self;
}
- (void)createMainView {
    self.commentLabel = [MLLinkLabel new];
    self.commentLabel.font = [UIFont systemFontOfSize:14];
    self.commentLabel.delegate = self;
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : CommentCellHighlightedColor};
    [self.contentView addSubview:self.commentLabel];
    
    self.commentLabel.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .topSpaceToView(self.contentView, 5)
    .rightSpaceToView(self.contentView, 5)
    .autoHeightRatio(0);
}

- (void)setCommentModel:(DYMonents1CellCommentItemModel *)commentModel {
    _commentModel = commentModel;
    if (!commentModel.attributedContent) {
        commentModel.attributedContent = [self generateAttributedStringWithCommentItemModel:commentModel];
    }
    self.commentLabel.attributedText = commentModel.attributedContent;
    
    [self setupAutoHeightWithBottomView:self.commentLabel bottomMargin:6];
}

#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(DYMonents1CellCommentItemModel *)model {
    NSString *text = model.firstUserName;
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentString]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : model.firstUserId} range:NSMakeRange(0, model.firstUserName.length)];
    
    if (model.secondUserName) {
        [attString setAttributes:@{NSLinkAttributeName : model.secondUserId} range:NSMakeRange(2 + model.firstUserName.length, model.secondUserName.length)];
    }
    return attString;
}


#pragma mark --- MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel {
    NSLog(@"%@", link.linkValue);
}


@end
