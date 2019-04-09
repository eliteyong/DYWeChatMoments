//
//  DYSheetRightTableViewCell.m
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import "DYSheetRightTableViewCell.h"
#import "DYSheetTopCollectionCell.h"

@interface DYSheetRightTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation DYSheetRightTableViewCell

+ (instancetype)dy_sheetRightTableViewCellForTaleView:(UITableView *)tableView {
    DYSheetRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYSheetRightTableViewCell"];
    if (cell == nil) {
        cell = [[DYSheetRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYSheetRightTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
- (void)createMainView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.cellCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.cellCollectionView registerClass:[DYSheetTopCollectionCell class] forCellWithReuseIdentifier:@"DYSheetTopCollectionCell1"];
    self.cellCollectionView.delegate = self;
    self.cellCollectionView.dataSource = self;
    self.cellCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cellCollectionView];
    [self.cellCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.numberOfSectionsBlock();
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfItemsBlock(section);
}
- (CGSize)collectionView:(UICollectionView *)uiCollectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.sizeForItemBlock(collectionViewLayout,indexPath);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYSheetTopCollectionCell *innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DYSheetTopCollectionCell1" forIndexPath:indexPath];
    innerCell.bgColor = [UIColor whiteColor];
    NSString *name = self.cellForItemBlock(indexPath);
    innerCell.name = name;
    return innerCell;
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.contentCellScrollBlock) {
        self.contentCellScrollBlock(scrollView);
    }
}

@end
