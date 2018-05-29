//
//  DYFMDBMainViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYFMDBMainViewController.h"
#import "DYPerson.h"
#import "DYCar.h"
#import "DYPersonCarDataBase.h"
#import "DYPersonCarViewController.h"

@interface DYFMDBMainViewController ()

@end

@implementation DYFMDBMainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [[DYPersonCarDataBase sharedPersonCarDataBase] getAllPerson];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AdjustsScrollViewInsetNever(self, self.tableView);
    self.navigationItem.title = @"FMDB";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addData)];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, DYNavbarHeight, DYScreenWidth, DYScreenHeight - DYNavbarHeight - DYBottomSafeHeight);
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return DYAlmostZero;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    DYPerson *person = self.dataArray[indexPath.row];
    
    if (person.number == 0) {
        cell.textLabel.text = person.name;
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@(第%ld次更新)",person.name,person.number];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %ld",person.age];
    
    return cell;
}

/**
 设置删除按钮
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        DYPerson *person = self.dataArray[indexPath.row];
        
        [[DYPersonCarDataBase sharedPersonCarDataBase] deletePerson:person];
        [[DYPersonCarDataBase sharedPersonCarDataBase] deleteAllCarsFromPerson:person];
    
        self.dataArray = [[DYPersonCarDataBase sharedPersonCarDataBase] getAllPerson];
        
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DYPerson *person = self.dataArray[indexPath.row];
    DYPersonCarViewController *vc = [[DYPersonCarViewController alloc] init];
    vc.person = person;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Action
/**
 添加数据到数据库
 */
- (void)addData {
    
    NSLog(@"addData");
    
    int nameRandom = arc4random_uniform(1000);
    NSInteger ageRandom  = arc4random_uniform(100) + 1;
    
    NSString *name = [NSString stringWithFormat:@"person_%d号",nameRandom];
    NSInteger age = ageRandom;
    
    DYPerson *person = [[DYPerson alloc] init];
    person.name = name;
    person.age = age;
    
    [[DYPersonCarDataBase sharedPersonCarDataBase] addPerson:person];
    
    self.dataArray = [[DYPersonCarDataBase sharedPersonCarDataBase] getAllPerson];
    
    [self.tableView reloadData];
}

@end
