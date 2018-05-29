//
//  DYPersonCarDataBase.m
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYPersonCarDataBase.h"
#import "DYPerson.h"
#import "DYCar.h"

static DYPersonCarDataBase *_personCarDBCtl = nil;

@interface DYPersonCarDataBase () <NSCopying,NSMutableCopying> {
    FMDatabase *_DB;
}

@end

@implementation DYPersonCarDataBase

+ (instancetype)sharedPersonCarDataBase {
    if (_personCarDBCtl == nil) {
        _personCarDBCtl = [[DYPersonCarDataBase alloc] init];
        [_personCarDBCtl initDataBase];
    }
    return _personCarDBCtl;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (_personCarDBCtl == nil) {
        _personCarDBCtl = [super allocWithZone:zone];
    }
    return _personCarDBCtl;
}

- (void)initDataBase {
    //获取Documents目录路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //获取文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"person_car.sqlite"];
    NSLog(@"filePath = %@",filePath);
    //实例化对象
    _DB = [FMDatabase databaseWithPath:filePath];
    //在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [_DB open];
    if (![_DB open]) {
        NSLog(@"_DB open fail");
        return;
    }
    
    //数据库中创建表（可创建多张）
    
    // 初始化数据表
    NSString *personSql = @"CREATE TABLE 'person' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number'VARCHAR(255)) ";
    NSString *carSql = @"CREATE TABLE 'car' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'car_id' VARCHAR(255),'car_brand' VARCHAR(255),'car_price'VARCHAR(255)) ";

    //执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL resultPerson = [_DB executeUpdate:personSql];
    BOOL resultCar = [_DB executeUpdate:carSql];
    if (resultPerson) {
        NSLog(@"create personSql success");
    }
    if (resultCar) {
        NSLog(@"create carSql success");
    }
    
    [_DB close];
}

#pragma mark --- person接口
- (void)addPerson:(DYPerson *)person {
    [_DB open];
    NSNumber *maxID = @(0);
    FMResultSet *resultSet = [_DB executeQuery:@"SELECT * FROM person"];
    //获取数据库中最大的ID
    while ([resultSet next]) {
        if ([maxID integerValue] < [[resultSet stringForColumn:@"person_id"] integerValue]) {
            maxID = @([[resultSet stringForColumn:@"person_id"] integerValue]);
        }
    }
    maxID = @([maxID integerValue] + 1);
    
    [_DB executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)VALUES(?,?,?,?)",maxID,person.name,@(person.age),@(person.number)];

    [_DB close];
}
- (void)deletePerson:(DYPerson *)person {
    [_DB open];
    [_DB executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];
    [_DB close];
}
- (void)updatePerson:(DYPerson *)person {
    [_DB open];
    
    [_DB executeUpdate:@"UPDATE 'person' SET person_name = ?  WHERE person_id = ? ",person.name,person.ID];
    [_DB executeUpdate:@"UPDATE 'person' SET person_age = ?  WHERE person_id = ? ",@(person.age),person.ID];
//    [_DB executeUpdate:@"UPDATE 'person' SET person_number = ?  WHERE person_id = ? ",@(person.number + 1),person.ID];
    [_DB executeUpdate:@"UPDATE 'person' SET person_number = ?  WHERE person_id = ? ",@(person.number),person.ID];

    [_DB close];
}
- (NSMutableArray *)getAllPerson {
    [_DB open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    FMResultSet *res = [_DB executeQuery:@"SELECT * FROM person"];
    while ([res next]) {
        DYPerson *person = [[DYPerson alloc] init];
        person.ID = @([[res stringForColumn:@"person_id"] integerValue]);
        person.name = [res stringForColumn:@"person_name"];
        person.age = [[res stringForColumn:@"person_age"] integerValue];
        person.number = [[res stringForColumn:@"person_number"] integerValue];
        
        [dataArray addObject:person];
        NSLog(@"person_id----%@,person.name---%@,person.number---%ld",person.ID,person.name,person.number);
    }
    
    [_DB close];
    
    return dataArray;
}
#pragma mark --- Car
- (void)addCar:(DYCar *)car toPerson:(DYPerson *)person {
    [_DB open];
    
    //根据person是否拥有car来添加car_id
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_DB executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@ ",person.ID]];
    
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"car_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"car_id"] integerValue]);
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_DB executeUpdate:@"INSERT INTO car(own_id,car_id,car_brand,car_price)VALUES(?,?,?,?)",person.ID,maxID,car.brand,@(car.price)];
    
    [_DB close];
}
- (void)deleteCar:(DYCar *)car fromPerson:(DYPerson *)person {
    [_DB open];
    [_DB executeUpdate:@"DELETE FROM car WHERE own_id = ?  and car_id = ? ",person.ID,car.car_id];
    [_DB close];
}
- (NSMutableArray *)getAllCarsFromPerson:(DYPerson *)person {
    [_DB open];
    NSMutableArray  *carArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_DB executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@",person.ID]];
    while ([res next]) {
        DYCar *car = [[DYCar alloc] init];
        car.own_id = person.ID;
        car.car_id = @([[res stringForColumn:@"car_id"] integerValue]);
        car.brand = [res stringForColumn:@"car_brand"];
        car.price = [[res stringForColumn:@"car_price"] integerValue];
        
        [carArray addObject:car];
    }
    [_DB close];
    
    return carArray;
}
- (void)deleteAllCarsFromPerson:(DYPerson *)person {
    [_DB open];
    [_DB executeUpdate:@"DELETE FROM car WHERE own_id = ?",person.ID];
    [_DB close];
}
- (void)updateCar:(DYCar *)car inPerson:(DYPerson *)person {
    
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

// 简书 - @“”https://www.jianshu.com/p/7958d31c2a97

@end
