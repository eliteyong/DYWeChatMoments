//
//  DYSheetView.m
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import "DYSheetView.h"
#import "DYSheetTopLeftView.h"
#import "DYSheetLeftTableViewCell.h"
#import "DYSheetTopCollectionCell.h"
#import "DYSheetRightTableViewCell.h"

@interface DYSheetView () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UICollectionView *topCollectionView;
@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) DYSheetTopLeftView *lableView;
/**
 行高
 */
@property (nonatomic, assign) CGFloat rowHeight;
/**
 行宽
 */
@property (nonatomic, assign) CGFloat rowWidth;

@property (nonatomic, assign) CGFloat currentInnerContentOffsetX;

@end

@implementation DYSheetView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createMainView];
    }
    return self;
}

- (void)createMainView {
    //左边的上下滑动的tableView
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.leftTableView];

    //右边上面左右滑动的collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.topCollectionView.showsHorizontalScrollIndicator = NO;
    self.topCollectionView.backgroundColor = DYColor(242, 244, 254, 1);
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    [self addSubview:self.topCollectionView];
    [self.topCollectionView registerClass:[DYSheetTopCollectionCell class] forCellWithReuseIdentifier:@"DYSheetTopCollectionCell"];
    
    //右边可上下和左右滚动的
    self.contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.showsVerticalScrollIndicator = NO;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.contentTableView];
    
}

#pragma mark --- UITableViewDelegate And DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource dy_numberOfSectionInSheetView:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource dy_sheetView:self numberOfRowsInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(&*self) weakSelf = self;
    if (tableView == self.leftTableView) {
        DYSheetLeftTableViewCell *leftCell = [DYSheetLeftTableViewCell dy_sheetLeftTableViewCellForTableView:tableView];
        leftCell.name = [self.dataSource dy_sheetView:self cellForLeftTableViewRowAtIndexPath:indexPath];
        leftCell.bgColor = DYColor(242, 244, 245, 1);
        return leftCell;
    }
    
    DYSheetRightTableViewCell *rightCell = [DYSheetRightTableViewCell dy_sheetRightTableViewCellForTaleView:tableView];
    rightCell.cellForItemBlock = ^NSString *(NSIndexPath *innerIndexPath) {
        return [self.dataSource dy_sheetView:self cellForContentItemAtIndexRow:indexPath.row indexCol:innerIndexPath.row section:indexPath.section];
    };
    rightCell.sizeForItemBlock = ^CGSize(UICollectionViewLayout *layout, NSIndexPath *indexPath) {
        return CGSizeMake(100, 44);
    };
    rightCell.numberOfSectionsBlock = ^NSInteger{
        return [self.dataSource dy_numberOfSectionInSheetView:self];
    };
    rightCell.numberOfItemsBlock = ^NSInteger(NSInteger section) {
        return [self.dataSource dy_sheetView:self numberOfRowsInSection:section];
    };
    rightCell.contentCellScrollBlock = ^(UIScrollView *scrollView) {
        for (DYSheetRightTableViewCell *currentCell in self.contentTableView.visibleCells) {
            currentCell.cellCollectionView.contentOffset = scrollView.contentOffset;
        }
        weakSelf.topCollectionView.contentOffset = scrollView.contentOffset;
        [weakSelf changeLeftTableViewShadowByCotentOffsetX:scrollView.contentOffset.x];
        weakSelf.currentInnerContentOffsetX = scrollView.contentOffset.x;
    };
    rightCell.cellOffsetX = self.currentInnerContentOffsetX;
    
//    rightCell.cellCollectionView.frame
    [rightCell.cellCollectionView reloadData];
    return rightCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return;
    }
    DYSheetRightTableViewCell *willDisplayCell = (DYSheetRightTableViewCell *)cell;
    DYSheetRightTableViewCell *didDisplayCell = (DYSheetRightTableViewCell *)[tableView.visibleCells firstObject];
    if (willDisplayCell.cellCollectionView && didDisplayCell.cellCollectionView && willDisplayCell.cellCollectionView.contentOffset.x != didDisplayCell.cellCollectionView.contentOffset.x) {
        willDisplayCell.cellCollectionView.contentOffset = didDisplayCell.cellCollectionView.contentOffset;
    }
}
#pragma mark --- UICollectionViewDelegate And DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource dy_sheetView:self numberOfColsInSection:section];
}


- (CGSize)collectionView:(UICollectionView *)uiCollectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 44);
}


#pragma mark --- 私有方法
- (void)changeLeftTableViewShadowByCotentOffsetX:(CGFloat)x {
//    if (x > 0) {
//        self.leftTableView.layer.masksToBounds = YES;
//        self.leftTableView.layer.shadowRadius  = 3.0;
//        self.leftTableView.layer.shadowOpacity = 0.3;
//        self.leftTableView.layer.shadowOffset  = CGSizeMake(0, 0);
//        self.leftTableView.layer.masksToBounds = false;
//        [self bringSubviewToFront:self.leftTableView];
//
//        self.labelView.layer.masksToBounds = YES;
//        self.labelView.layer.shadowRadius  = 3.0;
//        self.labelView.layer.shadowOpacity = 0.3;
//        self.labelView.layer.shadowOffset  = CGSizeMake(0, -3);
//        self.labelView.layer.masksToBounds = false;
//        [self bringSubviewToFront:self.labelView];
//    } else {
//        self.leftTableView.layer.shadowRadius  = 0;
//        self.leftTableView.layer.shadowOffset  = CGSizeMake(0, 0);
//
//        self.labelView.layer.shadowRadius  = 0;
//        self.labelView.layer.shadowOffset  = CGSizeMake(0, 0);
//    }
}

@end
