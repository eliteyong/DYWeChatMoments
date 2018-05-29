//
//  DYContactsViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYContactsViewController.h"
#import "DYSearchResultViewController.h"
#import "DYContactInfoModel.h"
#import "DYSearchPlacehoderView.h"
#import "DYContactTableViewCell.h"

@interface DYContactsViewController () <UISearchBarDelegate> {
    NSMutableArray *_dataSource;
    DYSearchResultViewController *_resultController;

}

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UITableView *friendTableView;

@property(nonatomic,strong) NSArray *lettersArray;
@property(nonatomic,strong) NSMutableDictionary *nameDic;

@property (nonatomic, strong) DYSearchPlacehoderView *placeHoderView;

@end

@implementation DYContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self configData];
    [self createMainView];
    [self loadAddressBookData];
    
    self.placeHoderView = [[DYSearchPlacehoderView alloc] initWithFrame:CGRectMake(0, DYNavbarHeight, DYScreenWidth, DYScreenHeight - DYNavbarHeight)];
    [_searchController.view addSubview:self.placeHoderView];
    
    __weak __typeof(self)weakSelf = self;
    
    _resultController.searchBarTextChangeBlock = ^(NSString *text) {
        if (text && text.length > 0) {
            [weakSelf.placeHoderView removeFromSuperview];
        } else {
            [weakSelf.searchController.view addSubview:weakSelf.placeHoderView];
        }
    };
    
    _resultController.searchResultClickPushBlock = ^{
        [weakSelf.navigationController pushViewController:[UIViewController new] animated:YES];
    };
    
    [_searchController.view bringSubviewToFront:_searchController.searchBar];
}

- (void)configData {
    _dataSource = [NSMutableArray array];
    self.lettersArray = [[NSArray alloc] init];
    self.nameDic = [[NSMutableDictionary alloc] init];
}

- (void)createMainView {
    self.friendTableView.tableHeaderView = self.searchController.searchBar;
    self.friendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadAddressBookData {
    NSData *friendsData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"json"]]];
    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:friendsData options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *eachDic in JSONDic[@"friends"][@"row"]) {
        [_dataSource addObject:[DYContactInfoModel modelWithDict:eachDic]];
    }
    [self handleLettersArray];
    [_friendTableView reloadData];
}


#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.lettersArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *nameArray = [self.nameDic objectForKey:self.lettersArray[section]];
    return nameArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DYContactTableViewCell fixedHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    for (UIView *aView in _friendTableView.subviews) {
        if ([aView isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
        } if ([aView isKindOfClass:NSClassFromString(@"UISearchBar")]) {
            [self.view bringSubviewToFront:aView];
        }
    }
    return [self.lettersArray objectAtIndex:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *nameArray = [self.nameDic objectForKey:self.lettersArray[indexPath.section]];

    DYContactInfoModel *frends = [[self.nameDic objectForKey:[self.lettersArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
//    cell.nameLabel.text = frends.userName;
//    [cell.photoIV sd_setImageWithURL:[NSURL URLWithString:frends.photo] placeholderImage:[UIImage imageNamed:@"default_portrait"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    
    
    DYContactTableViewCell *cell = [DYContactTableViewCell dy_contactTableViewCellForTableView:tableView];
    cell.model = frends;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//处理letterArray，包括按英文字母顺序排序
- (void)handleLettersArray {
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    for(DYContactInfoModel *friends  in _dataSource) {
        HanyuPinyinOutputFormat *formatter =  [[HanyuPinyinOutputFormat alloc] init];
        formatter.caseType = CaseTypeLowercase;
        formatter.vCharType = VCharTypeWithV;
        formatter.toneType = ToneTypeWithoutTone;
        
        NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:friends.userName withHanyuPinyinOutputFormat:formatter withNSString:@""];
        [tempDic setObject:friends forKey:[[outputPinyin substringToIndex:1] uppercaseString]];
    }
    self.lettersArray = tempDic.allKeys;
    for (NSString *letter in self.lettersArray) {
        NSMutableArray *tempArry = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < _dataSource.count; i++) {
            DYContactInfoModel *friends = _dataSource[i];
            HanyuPinyinOutputFormat *formatter =  [[HanyuPinyinOutputFormat alloc] init];
            formatter.caseType = CaseTypeUppercase;
            formatter.vCharType = VCharTypeWithV;
            formatter.toneType = ToneTypeWithoutTone;
            
            //把friend的userName汉子转为汉语拼音，比如：张磊---->zhanglei
            NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:friends.userName withHanyuPinyinOutputFormat:formatter withNSString:@""];
            if ([letter isEqualToString:[[outputPinyin substringToIndex:1] uppercaseString]]) {
                [tempArry addObject:friends];
                
            }
            
        }
        [self.nameDic setObject:tempArry forKey:letter];
    }
    
    self.lettersArray = tempDic.allKeys;
    //排序，排序的根据是字母
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 characterAtIndex:0] > [obj2 characterAtIndex:0]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    self.lettersArray = [[NSMutableArray alloc]initWithArray:[self.lettersArray sortedArrayUsingComparator:cmptr]];
}
- (UITableView *)friendTableView {
    if (_friendTableView == nil) {
        
        _friendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DYScreenWidth, DYScreenHeight) style:UITableViewStylePlain];
        [self.view addSubview:_friendTableView];
        _friendTableView.delegate = self;_friendTableView.dataSource = self;
        
        //设置右边索引index的字体颜色和背景颜色
        _friendTableView.sectionIndexColor = [UIColor darkGrayColor];
        _friendTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _friendTableView.tableFooterView = [UIView new];
    }
    return _friendTableView;
}

- (UISearchController *)searchController {
    if (_searchController == nil) {
        
        _resultController = [[DYSearchResultViewController alloc] init];
        _resultController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        //searchController
        _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultController];
        _searchController.searchResultsUpdater = _resultController;
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.tintColor = DYThemeColor;
        _searchController.searchBar.delegate = self;
        //    searchController.searchBar.searchTextPositionAdjustment = UIOffsetMake(0, 0);
        
        //解决iOS 8.4中searchBar看不到的bug
        UISearchBar *bar = _searchController.searchBar;
        bar.barStyle = UIBarStyleDefault;
        bar.translucent = YES;
        CGRect rect = bar.frame;
        rect.size.height = 44;
        bar.frame = rect;
        
        //    self.definesPresentationContext = NO;
        //设置searchBar的边框颜色，四周的颜色
        _searchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
        UIImageView *view = [[[_searchController.searchBar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        view.layer.borderWidth = 1;
        _searchController.searchBar.backgroundColor = DYColor(239, 239, 244, 1);
        
        [[UISearchBar appearance] setSearchFieldBackgroundImage:[self searchFieldBackgroundImage] forState:UIControlStateNormal];
        UITextField *txfSearchField = [_searchController.searchBar valueForKey:@"_searchField"];
        [txfSearchField setDefaultTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.5]}];
        _searchController.searchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);

        //把UISearchBar的右边图标显示出来
        _searchController.searchBar.showsBookmarkButton = YES;
        //把UISearchBar的右边图标替换为VoiceSearchStartBtn这个图标
        [_searchController.searchBar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        // 将searchBar的cancel按钮改成中文的
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
        self.definesPresentationContext = YES;
        
    }
    return _searchController;
}
- (UIImage *)searchFieldBackgroundImage {
    
    UIColor*color = [UIColor whiteColor];
    CGFloat cornerRadius = 5;
    CGRect rect = CGRectMake(0,0,28,28);
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth=0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
