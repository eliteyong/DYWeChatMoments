//
//  DYRootTabBarController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYRootTabBarController.h"
#import "DYBaseNavigationController.h"

#define kClassKey       @"rootVCClassString"
#define kTitleKey       @"title"
#define kImgKey         @"imageName"
#define kSelImgKey      @"selectedImageName"

@interface DYRootTabBarController ()

@end

@implementation DYRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"DYHomeViewController",
                                   kTitleKey  : @"微信",
                                   kImgKey    : @"tabbar_mainframe",
                                   kSelImgKey : @"tabbar_mainframeHL"},
                                 
                                 @{kClassKey  : @"DYContactsViewController",
                                   kTitleKey  : @"通讯录",
                                   kImgKey    : @"tabbar_contacts",
                                   kSelImgKey : @"tabbar_contactsHL"},
                                 
                                 @{kClassKey  : @"DYDiscoverViewController",
                                   kTitleKey  : @"发现",
                                   kImgKey    : @"tabbar_discover",
                                   kSelImgKey : @"tabbar_discoverHL"},
                                 
                                 @{kClassKey  : @"DYMeViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tabbar_me",
                                   kSelImgKey : @"tabbar_meHL"}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        DYBaseNavigationController *nav = [[DYBaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : DYThemeColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}


@end
