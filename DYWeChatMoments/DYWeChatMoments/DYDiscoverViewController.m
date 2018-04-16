//
//  DYDiscoverViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDiscoverViewController.h"
#import "DYDiscoverListCell.h"

@interface DYDiscoverViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray *titles;

@end

@implementation DYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titles = @[
                    @[
                        @{@"朋友圈1":@"ff_IconShowAlbum"},
                        @{@"朋友圈2":@"ff_IconShowAlbum"},
                        ],
                    
                    @[
                        @{@"扫一扫":@"ff_IconQRCode"},
                        @{@"摇一摇":@"ff_IconShake"},
                        ],
                    
                    @[
                        @{@"看一看":@"ff_IconShowAlbum"},
                        @{@"搜一搜":@"ff_IconShowAlbum"},
                    ],
                    
                    @[
                        @{@"漂流瓶":@"ff_IconShowAlbum"},
                        ],
                    
                    @[
                        @{@"购物":@"CreditCard_ShoppingBag"},
                        @{@"游戏":@"MoreGame"},
                        ],
                    
                    @[
                        @{@"小程序":@"ff_IconShowAlbum"},
                        ],
                  ];
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArr = self.titles[section];
    return sectionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.titles.count - 1) {
        return 25;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArr = self.titles[indexPath.section];
    NSDictionary *dic = sectionArr[indexPath.row];
    
    DYDiscoverListCell *cell = [DYDiscoverListCell dy_discoverListCellForTableView:tableView];
    cell.dict = dic;
    cell.isHiddenLine = indexPath.row == sectionArr.count - 1;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
