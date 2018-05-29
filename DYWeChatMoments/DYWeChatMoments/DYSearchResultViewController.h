//
//  DYSearchResultViewController.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/26.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYSearchPlacehoderView.h"

@interface DYSearchResultViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic, copy) void (^searchBarTextChangeBlock)(NSString *text);

@property (nonatomic, strong) DYSearchPlacehoderView *placehoderView;

@property (nonatomic, copy) void (^searchResultClickPushBlock)();

@end
