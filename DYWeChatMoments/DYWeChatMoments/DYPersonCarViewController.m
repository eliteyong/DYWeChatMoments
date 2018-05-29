//
//  DYPersonCarViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYPersonCarViewController.h"

#import "DYPerson.h"
#import "DYCar.h"
#import "DYPersonCarDataBase.h"

@interface DYPersonCarViewController ()

@end

@implementation DYPersonCarViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dataArray = [[DYPersonCarDataBase sharedPersonCarDataBase] getAllCarsFromPerson:self.person];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@的所有车",self.person.name];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCar)];
    
    AdjustsScrollViewInsetNever(self, self.tableView);
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, DYNavbarHeight, DYScreenWidth, DYScreenHeight - DYNavbarHeight - DYBottomSafeHeight);
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
}

- (void)addCar {
    DYCar *car = [[DYCar alloc] init];
    car.own_id = self.person.ID;
    
    NSArray *brandArray = [NSArray arrayWithObjects:@"大众",@"宝马",@"奔驰",@"奥迪",@"保时捷",@"兰博基尼", nil];
    NSInteger index = arc4random_uniform((int)brandArray.count);
    car.brand = [brandArray objectAtIndex:index];
    
    car.price = arc4random_uniform(1000000);
    
    [[DYPersonCarDataBase sharedPersonCarDataBase] addCar:car toPerson:self.person];
    
    self.dataArray = [[DYPersonCarDataBase sharedPersonCarDataBase] getAllCarsFromPerson:self.person];
    
    [self.tableView reloadData];
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
    
    DYCar *car = self.dataArray[indexPath.row];
    
    cell.textLabel.text = car.brand;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"price: ￥%ld " ,car.price];
    return cell;
}

/**
 设置删除按钮
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DYCar *car = self.dataArray[indexPath.row];
        NSLog(@"car.id--%@,own_id--%@",car.car_id,car.own_id);
        [[DYPersonCarDataBase sharedPersonCarDataBase] deleteCar:car fromPerson:self.person];
        self.dataArray = [[DYPersonCarDataBase sharedPersonCarDataBase] getAllCarsFromPerson:self.person];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
