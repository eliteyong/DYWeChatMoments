//
//  DYContactInfoModel.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/26.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYContactInfoModel.h"

@implementation DYContactInfoModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
