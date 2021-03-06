//
//  DYMomentsBaseViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/16.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMomentsBaseViewController.h"

@interface DYMomentsBaseViewController ()

@property (nonatomic, strong) NSDictionary *jsonDic;

@end

@implementation DYMomentsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    [self.view addSubview:self.tableView];

    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DYScreenWidth, 260)];
    backgroundImageView.image = [UIImage imageNamed:@"pbg.jpg"];
    self.tableView.tableHeaderView = backgroundImageView;
}



//本地的json测试数据
- (NSDictionary *)jsonDic {
    if (_jsonDic == nil) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]];
        _jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return _jsonDic;
}

@end
