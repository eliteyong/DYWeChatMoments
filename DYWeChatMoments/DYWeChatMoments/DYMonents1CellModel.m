//
//  DYMonents1CellModel.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMonents1CellModel.h"
#import <UIKit/UIKit.h>

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation DYMonents1CellModel {
    CGFloat _lastContentWidth;
}
@synthesize msgContent = _msgContent;


- (void)setMsgContent:(NSString *)msgContent {
    _msgContent = msgContent;
}

- (NSString *)msgContent {
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

@end

@implementation DYMonents1CellLikeItemModel

@end

@implementation DYMonents1CellCommentItemModel

@end
