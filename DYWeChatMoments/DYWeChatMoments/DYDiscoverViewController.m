//
//  DYDiscoverViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDiscoverViewController.h"
#import "DYDiscoverListCell.h"

#import "DYMomentsFirstViewController.h"
#import "DYFMDBMainViewController.h"

@interface DYDiscoverViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@end

@implementation DYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.titles = @[
                    @[
                        @{@"朋友圈SDAutoLayout":@"ff_IconShowAlbum"},
                        @{@"FMDB的使用":@"ff_IconQRCode"},
                        @{@"朋友圈3":@"ff_IconShake"},
                        ],
                    
                    @[
                        @{@"扫一扫":@"ff_IconQRCode"},
                        @{@"摇一摇":@"ff_IconShake"},
                        ],
                    
                    @[
                        @{@"看一看":@"ff_IconQRCode"},
                        @{@"搜一搜":@"ff_IconShake"},
                    ],
                    
                    @[
                        @{@"附近的人":@"ff_IconLocationService"},
                        @{@"漂流瓶":@"ff_IconBottle"},
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11,*)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }
        if (@available(iOS 11,*)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.mas_topLayoutGuide);
        }
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArr = self.titles[section];
    return sectionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
    
    if (indexPath.section == 0) {
        NSArray *section0Arr = @[@"DYMomentsFirstViewController",@"DYFMDBMainViewController",@"DYMomentsFirstViewController"];
        [self getInToVCWithVcName:section0Arr[indexPath.row]];
//        if (indexPath.row == 0) {
//            DYMomentsFirstViewController *vc = [[DYMomentsFirstViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        if (indexPath.row == 1) {
////            DYFMDBMainViewController *vc
//        }
    }
}

//  根据vc的名字进入对应的vc
- (void)getInToVCWithVcName:(NSString *)vcName {
    
    UIViewController *targetVC;
    Class VCClass = NSClassFromString(vcName);
    targetVC = [[VCClass alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
}

@end
