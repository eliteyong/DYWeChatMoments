//
//  DYContactsViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYContactsViewController.h"

@interface DYContactsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;
@end

@implementation DYContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
