//
//  DYBaseNavigationController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYBaseNavigationController.h"

@interface DYBaseNavigationController ()

@end

@implementation DYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    CGFloat rgb = 0.1;
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
