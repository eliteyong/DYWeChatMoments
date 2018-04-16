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

@property (nonatomic, strong) UITableView *tableView;
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
                        @{@"朋友圈1":@"ff_IconShowAlbum"},
                        @{@"朋友圈2":@"ff_IconShowAlbum"},
                    ],
                    
                    @[
                        @{@"朋友圈1":@"ff_IconShowAlbum"},
                        @{@"朋友圈2":@"ff_IconShowAlbum"},
                    ],
                    
                    @[
                        @{@"朋友圈1":@"ff_IconShowAlbum"},
                        @{@"朋友圈2":@"ff_IconShowAlbum"},
                    ],
                    
                    @[
                        @{@"朋友圈1":@"ff_IconShowAlbum"},
                        @{@"朋友圈2":@"ff_IconShowAlbum"},
                    ],
                  ];
    [self.view addSubview:self.tableView];
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
    DYDiscoverListCell *cell = [DYDiscoverListCell dy_discoverListCellForTableView:tableView];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

@end
