//
//  DYMoments1CommentContainerView.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/20.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMoments1CommentContainerView.h"

#import "DYMonets1CommentCell.h"

@interface DYMoments1CommentContainerView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *tempView;
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
    self.backgroundColor = DYColorSame(240);
    
    self.tempView = [UIView new];
    [self addSubview:self.tempView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;//不允许滑动
    [self addSubview:self.tableView];
    
    self.tempView.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .heightIs(DYAlmostZero);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentItemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.commentItemsArray[indexPath.row];
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

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray {
    
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;

    [self.tableView reloadData];
    
    CGFloat tableViewHeight = self.tableView.cellsTotalHeight;
    
    self.tableView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self.tempView, 0);
    
    CGFloat margin = 0;
    
    if (self.commentItemsArray.count > 0) {
        self.tableView.sd_layout.heightIs(tableViewHeight);
        [self setupAutoHeightWithBottomView:self.tempView bottomMargin:margin + tableViewHeight];
    } else {
        self.tableView.sd_layout.heightIs(0);
        [self setupAutoHeightWithBottomView:self.tempView bottomMargin:margin];
    }
}

@end
