//
//  DYPerson.h
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYPerson : NSObject

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) NSInteger number;

/**
 车辆数组
 */
@property (nonatomic, strong) NSMutableArray *carArray;

@end
