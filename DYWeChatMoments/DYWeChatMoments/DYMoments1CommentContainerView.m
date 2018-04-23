//
//  DYMoments1CommentContainerView.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/20.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMoments1CommentContainerView.h"
#import "DYMonets1CommentCell.h"
#import "MLLinkLabel.h"

@interface DYMoments1CommentContainerView () <UITableViewDelegate,UITableViewDataSource,MLLinkLabelDelegate>

@property (nonatomic, strong) UIView *tempView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;

@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSArray *commentItemsArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DYMoments1CommentContainerView

- (instancetype)init {
    if (self = [super init]) {
        [self createMainView];
    }
    return self;
}

- (void)createMainView {
    self.backgroundColor = DYColorSame(111);
    
    self.tempView = [UIView new]; self.tempView.backgroundColor = DYColorSame(220);
    [self addSubview:self.tempView];
    
    _likeLabel = [MLLinkLabel new];
    _likeLabel.font = [UIFont systemFontOfSize:14];
    _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : DYColor(92, 140, 193, 1)};
    _likeLabel.numberOfLines = 0;
    _likeLabel.isAttributedContent = YES;
    _likeLabel.delegate = self;
    [self addSubview:_likeLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;//不允许滑动
    [self addSubview:self.tableView];
    
    self.likeLabel.sd_layout
    .leftSpaceToView(self, 5)
    .topSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .autoHeightRatio(0);
    
    self.tempView.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self.likeLabel, 0)
    .rightSpaceToView(self, 0)
    .heightIs(DYAlmostZero);
}

#pragma mark --- UITableViewDelegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentItemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.commentItemsArray[indexPath.row];
    
#warning 这一步还是用到了superView里面的数据，考虑咋解决
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"commentModel" cellClass:[DYMonets1CommentCell class] contentViewWidth:DYScreenWidth - 30 - 40];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return DYAlmostZero;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYMonets1CommentCell *cell = [DYMonets1CommentCell dy_monets1CommentCellForTableView:tableView];
    cell.commentModel = self.commentItemsArray[indexPath.row];
    
    //此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DYMonents1CellCommentItemModel *model = self.commentItemsArray[indexPath.row];
    if (self.dy_moments1CommentClickBlock) {
        self.dy_moments1CommentClickBlock(indexPath, model);
    }
}

//初始化数据
- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray {
    
    self.likeItemsArray = likeItemsArray;//把富文本赋值了
    self.commentItemsArray = commentItemsArray;

    //根据点赞数组判断 likeLabel的显示与layout
    if (likeItemsArray.count) {
        self.likeLabel.sd_layout
        .topSpaceToView(self, 5)
        .autoHeightRatio(0);
        
        self.tempView.sd_layout.topSpaceToView(self.likeLabel, 5);
    } else {
        _likeLabel.attributedText = nil;
        _likeLabel.sd_layout
        .topSpaceToView(self, 0)
        .heightIs(0);
        
        self.tempView.sd_layout.topSpaceToView(self.likeLabel, 0);
    }
    
    //判断这个横线的height
    if (likeItemsArray.count && commentItemsArray.count) {
        self.tempView.sd_layout.heightIs(1);
    } else {
        self.tempView.sd_layout.heightIs(0);
    }
    
    //tableView的layout
    self.tableView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self.tempView, 0);
    
    [self.tableView reloadData];
    CGFloat tableViewHeight = self.tableView.cellsTotalHeight;
    
    if (self.commentItemsArray.count > 0) {
        self.tableView.sd_layout.heightIs(tableViewHeight);
    } else {
        self.tableView.sd_layout.heightIs(0);
    }

    [self setupAutoHeightWithBottomView:self.tableView bottomMargin:0];
}


#pragma mark --- setter

- (void)setLikeItemsArray:(NSArray *)likeItemsArray {
    
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    
    for (int i = 0; i < likeItemsArray.count; i++) {
        DYMonents1CellLikeItemModel *model = likeItemsArray[i];
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        if (!model.attributedContent) {
            model.attributedContent = [self generateAttributedStringWithLikeItemModel:model];
        }
        [attributedText appendAttributedString:model.attributedContent];
    }
    
    _likeLabel.attributedText = [attributedText copy];
}

#pragma mark --- private actions

- (NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(DYMonents1CellLikeItemModel *)model {
    NSString *text = model.userName;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blueColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.userId} range:[text rangeOfString:model.userName]];
    
    return attString;
}

#pragma mark --- MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel {
    NSLog(@"%@", link.linkValue);
}

@end
