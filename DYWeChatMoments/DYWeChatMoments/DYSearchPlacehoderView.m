//
//  DYSearchPlacehoderView.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/27.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYSearchPlacehoderView.h"

@interface DYSearchPlacehoderView ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation DYSearchPlacehoderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       _iconImageView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) image:[UIImage imageNamed:@"DYContact_Search_placehoder"]];
        [self addSubview:_iconImageView];
    }
    return self;
}


@end
