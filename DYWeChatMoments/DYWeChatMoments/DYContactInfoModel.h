//
//  DYContactInfoModel.h
//  DYWeChatMoments
//
//  Created by admin on 2018/4/26.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYContactInfoModel : NSObject


@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *phoneNO;
@property (nonatomic, assign) NSRange range;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;



@end
