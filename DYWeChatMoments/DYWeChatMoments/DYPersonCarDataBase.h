//
//  DYPersonCarDataBase.h
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYPerson;
@class DYCar;

@interface DYPersonCarDataBase : NSObject
//@property (nonatomic, strong) DYPerson *person;

+ (instancetype)sharedPersonCarDataBase;

#pragma mark --- Person
/**
 添加person
 */
- (void)addPerson:(DYPerson *)person;
/**
 删除person
 */
- (void)deletePerson:(DYPerson *)person;
/**
 更新、修改person
 */
- (void)updatePerson:(DYPerson *)person;
/**
 得到所有的person数据的数组
 */
- (NSMutableArray *)getAllPerson;

#pragma mark --- Car
/**
 给Person添加Car
 */
- (void)addCar:(DYCar *)car toPerson:(DYPerson *)person;
/**
 给Person删除car
 */
- (void)deleteCar:(DYCar *)car fromPerson:(DYPerson *)person;
/**
 修改、更新Person的Car
 */
- (void)updateCar:(DYCar *)car inPerson:(DYPerson *)person;
/**
 得到Person的所有Car的数组
 */
- (NSMutableArray *)getAllCarsFromPerson:(DYPerson *)person;
/**
 删除Person的所有Car
 */
- (void)deleteAllCarsFromPerson:(DYPerson *)person;

@end
