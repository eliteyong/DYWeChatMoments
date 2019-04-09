//
//  DYSheetView.h
//  DYWeChatMoments
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class DYSheetView;

@protocol DYSheetViewDataSource <NSObject>

@required

/**
 返回多少组
 */
- (NSInteger)dy_numberOfSectionInSheetView:(DYSheetView *)sheetView;
/**
 返回表格有多少行
 后面的section如果只有一个的话可以不要，这里留着可以延伸
 */
- (NSInteger)dy_sheetView:(DYSheetView *)sheetView numberOfRowsInSection:(NSInteger)section;
/**
 返回表格有多少列
 */
- (NSInteger)dy_sheetView:(DYSheetView *)sheetView numberOfColsInSection:(NSInteger)section;
/**
 返回第section组，indexRow行，indexCol列所在item显示的字符串
 */
- (NSString *)dy_sheetView:(DYSheetView *)sheetView cellForContentItemAtIndexRow:(NSInteger)indexRow indexCol:(NSInteger)indexCol section:(NSInteger)section;
/**
 返回左边tableView每行显示的字符串
 */
- (NSString *)dy_sheetView:(DYSheetView *)sheetView cellForLeftTableViewRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 返回上面collectionView每列显示的字符串
 */
- (NSString *)dy_sheetView:(DYSheetView *)sheetView cellForTopCollectionColAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol DYSheetViewDelegate <NSObject>

@required

/**
 返回表格的高度
 */
- (CGFloat)dy_sheetView:(DYSheetView *)sheetView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 返回表格的宽度
 */
- (CGFloat)dy_sheetView:(DYSheetView *)sheetView widthForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 上拉加载更多
 */
- (void)dy_downLoandMoreDataWithSheetView:(DYSheetView *)sheetView;
/**
 下拉刷新数据
 */
- (void)dy_getNewestDataWithSheetView:(DYSheetView *)sheetView;


@end

@interface DYSheetView : UIView

/**
 表格的头显示内容
 第0行第0列的的内容
 */
@property (nonatomic, strong) NSString *sheetHeadString;

/**
 自动调节行高和列宽以适应SheetView
 */
@property (nonatomic, assign, getter=isAutoResizingItemMask) BOOL autoResizingItemMask;

/**
 数据源
 */
@property (nonatomic, weak) id <DYSheetViewDataSource> dataSource;

/**
 代理
 */
@property (nonatomic, weak) id <DYSheetViewDelegate> delegate;

/**
 刷新数据
 */
- (void)dy_reloadData;

@end
