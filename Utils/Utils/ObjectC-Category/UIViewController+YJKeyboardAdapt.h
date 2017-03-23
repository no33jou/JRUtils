//
//  UIViewController+YJKeyboardAdapt.h
//  Keyboard
//
//  Created by chen on 15/11/10.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YJKeyboardAdapt)

//文本框高于键盘的高度
@property(nonatomic, assign)CGFloat heightUpperKeyboard;

//是否点击空白收起键盘
@property(nonatomic, assign)BOOL tapToDismissKeyboard;


//start
- (void)autoAdaptkeyBoard;


//手动endEditing
- (void)endEdit;


@end
