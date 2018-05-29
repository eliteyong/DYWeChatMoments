//
//  DYCar.h
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYCar : NSObject

/**
 所有者
 */
@property (nonatomic, strong) NSNumber *own_id;

/**
 车的ID
 */
@property (nonatomic, strong) NSNumber *car_id;

@property (nonatomic, copy) NSString *brand;

@property (nonatomic, assign) NSInteger price;

@end
