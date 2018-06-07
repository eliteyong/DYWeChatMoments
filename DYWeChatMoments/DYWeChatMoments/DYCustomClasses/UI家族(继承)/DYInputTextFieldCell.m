//
//  DYInputTextFieldCell.m
//  DYWeChatMoments
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYInputTextFieldCell.h"

@interface DYInputTextFieldCell () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DYInputTextFieldCell

+ (instancetype)dy_inputTextFieldCellForTableView:(UITableView *)tableView {
    DYInputTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYInputTextFieldCell"];
    if (cell == nil) {
        cell = [[DYInputTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DYInputTextFieldCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createMainView];
    }
    return self;
}
- (void)createMainView {
//    self.nameLabel = [UILabel labelWithTextColor:<#(UIColor *)#> font:<#(UIFont *)#>]
}
@end
