//
//  DYMeViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMeViewController.h"
#import "DYDiscoverListCell.h"
#import "DYMeHeaderCell.h"

@interface DYMeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@end

@implementation DYMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titles = @[
                    
                    @[
                        @{@"钱包":@"MoreMyBankCard"},
                        ],
                    
                    @[
                       
                        @{@"收藏":@"MoreMyFavorites"},
                        @{@"相册":@"ff_IconShowAlbum"},
                        @{@"卡券":@"MyCardPackageIcon"},
                        @{@"表情":@"MoreExpressionShops"},
                        ],
                    
                    @[
                        @{@"设置":@"MoreSetting"},
                        ],
                    ];
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = CGRectMake(0, DYNavbarHeight, DYScreenWidth, DYScreenHeight - DYNavbarHeight - DYTabBarHeight);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    NSArray *sectionArr = self.titles[section - 1];
    return sectionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 88;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.titles.count) {
        return 25;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DYMeHeaderCell *cell = [DYMeHeaderCell dy_meHeaderCellForTableView:tableView];
        
        return cell;
    }
    NSArray *sectionArr = self.titles[indexPath.section - 1];
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
