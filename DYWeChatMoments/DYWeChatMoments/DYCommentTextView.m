//
//  DYCommentTextView.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYCommentTextView.h"

#define defaultHeight                   50
#define textViewDefaultHeight           34
#define spaceToLeft                     8
#define spaceToTop                      8

#define lineColor                       DYColorSame(200)
#define lineWidth                       0.5

@interface DYCommentTextView () <UITextViewDelegate>

@end

@implementation DYCommentTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.borderWidth = lineWidth;
        self.layer.borderColor = lineColor.CGColor;
        
        [self addSubview:self.textView];
        [self addSubview:self.submitBtn];
        
        self.textView.placeholder = @"请输入你的评论";
    }
    return self;
}


- (void)submitBtnClick {

}

- (DYPlacehoderTextView *)textView {
    if (_textView == nil) {
        _textView = [[DYPlacehoderTextView alloc] initWithFrame:CGRectMake(spaceToLeft, spaceToTop, DYScreenWidth - spaceToLeft - 55, textViewDefaultHeight)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.layer.cornerRadius = 3;
        _textView.layer.borderWidth = lineWidth;
        _textView.layer.borderColor = lineColor.CGColor;
        _textView.delegate = self;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.tintColor = DYColorSame(51);

    }
    return _textView;
}


- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithFrame:CGRectMake(DYScreenWidth - 50, spaceToTop, 45, textViewDefaultHeight) title:@"提交" titleLabelFont:[UIFont systemFontOfSize:15] titleColor:DYColorSame(51) backgroundColor:nil target:self action:@selector(submitBtnClick)];
        _submitBtn.layer.cornerRadius = 3;
        _submitBtn.layer.borderWidth = lineWidth;
        _submitBtn.layer.borderColor = lineColor.CGColor;
    }
    return _submitBtn;
}



@end
