//
//  CodeView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "CodeView.h"
#import "KeyTextField.h"

@interface CodeView ()
<UITextFieldDelegate,KeyTextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, assign) NSInteger editId;
@property (nonatomic, copy) NSString *tempStr;

@end

@implementation CodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _editId = 0;
        _tempStr = @"";
        _codeNum = 4;
        _codeWidth = AUTO_SCALE_W(40);
        _codeSpace = AUTO_SCALE_W(22);

        _textArray = [[NSMutableArray alloc]init];
        
        [self createView];
        
        if (_textArray.count != 0) {
            UITextField *text = _textArray[0];
            text.enabled = YES;
            [text becomeFirstResponder];
        }
    }
    
    return self;
}

- (void)createView {
    
    for (int i = 0; i < _codeNum; i++) {
        CGRect rect = CGRectMake((FUNC_W(self)-_codeNum*_codeWidth-(_codeNum-1)*_codeSpace)/2+i*(_codeWidth+_codeSpace), (FUNC_H(self)-_codeWidth)/2.0, _codeWidth, _codeWidth);

        KeyTextField *text = [[KeyTextField alloc]init];
        text.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        text.frame = rect;
        text.backgroundColor = kWHITE_COLOR;
        text.font = FONT(18.0);
        text.textColor = k1D_COLOR;
        text.layer.borderWidth = 1;
        text.layer.borderColor = UI_COLOR_FROM_RGB(0x23252c).CGColor;
        text.layer.cornerRadius = 3;
        text.layer.masksToBounds = YES;
        text.textAlignment = NSTextAlignmentCenter;
        text.enabled = NO;
        text.tag = i;
        text.kdelegate = self;
        text.delegate = self;
        [self addSubview:text];
        
        [_textArray addObject:text];
    }
}

// 删除
- (void)deleteBackward:(UITextField *)textField {
   
    // 最后一个输入框
    if (_editId == _codeNum-1) {
        if (_editId > 0) {
            _editId --;
            
        }
        return;
    }

    // 保留第一个输入框
    if (textField.tag > 0) {

        UITextField *text = _textArray[_editId];
        text.enabled = YES;
        
        // 不是最后一个输入框
        if (_editId != _codeNum-1) {
            text.text = @"";
            
            [textField resignFirstResponder];
            [text becomeFirstResponder];
        }
        
        if (_editId > 0) {
           _editId --;
        }
        
    }
    

}

// 输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    // 输入
    if (![string isNil]) {
        if (_editId < _codeNum-1) {
            
            _editId ++;
            UITextField *text2 = _textArray[_editId];
            text2.enabled = YES;;
            
            [UIView animateWithDuration:kDurationTime0 animations:^{
                
            } completion:^(BOOL finished) {
                [text2 becomeFirstResponder];
                //                UITextField *text1 = _textArray[_editId];
                //                text1.enabled = NO;
            }];
            
        }
        else {
            [UIView animateWithDuration:kDurationTime0 animations:^{
                
            } completion:^(BOOL finished) {
                [_textArray[_editId] resignFirstResponder];
            }];
            
        }
        
        _tempStr = [NSString stringWithFormat:@"%@%@", _tempStr, string];
    }

    // 只能输入一位数
    if ([textField.text length] >0 && [string length] != 0) {
        
        return NO;
    }
    
    // 输入完成后返回输入内容
    if ([_tempStr length] == _codeNum) {
        if (self.codeBlock) {
            self.codeBlock(_tempStr);
        }

    }
    
    return YES;
}

// 开始编辑-其他都不可编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    for (UITextField *text in _textArray) {
        if (text == textField) {
            text.enabled = YES;
        }
        else {
            text.enabled = NO;
        }
    }
}


// 取消下一项按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length] == 0) {
        return NO;
    }
    return YES;
}

@end
