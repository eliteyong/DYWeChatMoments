//
//  DYSheetRightTableViewCell.h
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString *(^DYCellForItemAtIndexPathBlock)(NSIndexPath *indexPath);
typedef NSInteger(^DYNumerOfSectionsBlock)();
typedef NSInteger(^DYNumberOfItemsInSectionBlock)(NSInteger section);
typedef CGSize(^DYSizeForItemAtIndexPathBlock)(UICollectionViewLayout *layout,NSIndexPath *indexPath);
typedef void(^DYContentViewCellDidScrollBlock)(UIScrollView *scrollView);
typedef UIColor *(^DYCellBackgroundColorAtIndexPathBlock)(NSIndexPath *indexPath);

@interface DYSheetRightTableViewCell : UITableViewCell

+ (instancetype)dy_sheetRightTableViewCellForTaleView:(UITableView *)tableView;

@property (nonatomic, strong) UICollectionView *cellCollectionView;
/**
 cell的偏移量
 (滚动的)
 */
@property (nonatomic, assign) CGFloat cellOffsetX;

/**
 cell显示的文字
 */
@property (nonatomic, copy) DYCellForItemAtIndexPathBlock cellForItemBlock;
/**
 section所含的items的个数
 */
@property (nonatomic, copy) DYNumberOfItemsInSectionBlock numberOfItemsBlock;
/**
 总共有多少section
 */
@property (nonatomic, copy) DYNumerOfSectionsBlock numberOfSectionsBlock;
/**
 item大小
 */
@property (nonatomic, copy) DYSizeForItemAtIndexPathBlock sizeForItemBlock;
/**
 内容cell滚动
 */
@property (nonatomic, copy) DYContentViewCellDidScrollBlock contentCellScrollBlock;
/**
 cell的颜色
 */
@property (nonatomic, copy) DYCellBackgroundColorAtIndexPathBlock cellColorBlock;

@end
