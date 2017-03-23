//
//  UIViewController+YJKeyboardAdapt.m
//  Keyboard
//
//  Created by chen on 15/11/10.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

#define KShowTime 0.1
#define KHideTime 0.1
#import <objc/runtime.h>
static const char *responseView = "responseView";
static const char *tapGesture= "tapOnceGesture";
#import "UIViewController+YJKeyboardAdapt.h"

@implementation UIViewController (YJKeyboardAdapt)

- (void)setHeightUpperKeyboard:(CGFloat)heightUpperKeyboard{
    objc_setAssociatedObject(self, @selector(heightUpperKeyboard), @(heightUpperKeyboard), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)heightUpperKeyboard{
    NSNumber *number = objc_getAssociatedObject(self, @selector(heightUpperKeyboard));
    return number.floatValue;
}

- (UIView *)responseView{
    return objc_getAssociatedObject(self, responseView);
}

- (void)setResponseView:(UIView *)view{
    objc_setAssociatedObject(self, responseView,
                             view, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)tapToDismissKeyboard{
    NSNumber *number = objc_getAssociatedObject(self, @selector(tapToDismissKeyboard));
    return number.boolValue;
}
- (void)setTapToDismissKeyboard:(BOOL)tapToDismissKeyboard{
    objc_setAssociatedObject(self, @selector(tapToDismissKeyboard), @(tapToDismissKeyboard), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setTapGesture:(UITapGestureRecognizer *)gesture{
    objc_setAssociatedObject(self, tapGesture, gesture, OBJC_ASSOCIATION_ASSIGN);
}

- (UITapGestureRecognizer *)tapGesture{
    return objc_getAssociatedObject(self, tapGesture);
}

- (void)autoAdaptkeyBoard{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    //添加tap手势
    if ([self tapToDismissKeyboard]) {
        [self addDismissKeyboardTapGestureRecognizer];
    }
    //处理键盘高度
    [self keyBoardshow:notification];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    if ([self tapToDismissKeyboard]) {
        [self removeTapGesture];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark -  height

- (void)keyBoardshow:(NSNotification *)notification{
    NSDictionary *userInfo=[notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    [UIView animateWithDuration:KHideTime animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    [self firstResponderView:self.view]; //从self.view上查找
    
    if ([self responseView] == nil) return ;
    
    CGRect ret = [[self responseView].superview convertRect:[self responseView].frame
                                                     toView:self.view];
    
    CGFloat moreHeight = CGRectGetMaxY(ret) + self.heightUpperKeyboard + keyboardRect.size.height - self.view.frame.size.height ;
    
    if (moreHeight > 0) {
        [UIView animateWithDuration:KShowTime animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -moreHeight);
        }];
    }
}

- (void)firstResponderView:(UIView *)baseView{
    if ([baseView isFirstResponder]) {
        //set 得到响应中的view
        [self setResponseView:baseView];
        return ;
    }
    if ([baseView isKindOfClass:[UITableView class]]) {
        [self searchFromTableViewCells:(UITableView *)baseView];
    }
    for (UIView *view in baseView.subviews) {
        [self firstResponderView:view];
    }
}

- (void)searchFromTableViewCells:(UITableView *)tableView{
    NSArray *cellArray = tableView.visibleCells;
    for (UITableViewCell *cell in cellArray) {
        [self firstResponderView:cell.contentView];
    }
}

#pragma mark - hideKeyBoard
//键盘点击隐藏
- (void)addDismissKeyboardTapGestureRecognizer{
    
    id target = nil ;
    if (self.navigationController != nil) {
        target  = self.navigationController ;
    }else{
        target  = self;
    }
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:target
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    [self.view addGestureRecognizer:singleTapGR];
    [self setTapGesture:singleTapGR];
}

- (void)removeTapGesture{
    [self.view removeGestureRecognizer:[self tapGesture]];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}


//移除通知
+ (void)load{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], NSSelectorFromString(@"deallcSwizzle"));
    method_exchangeImplementations(method1, method2);
}

- (void)deallcSwizzle{
    //这里不是死循环
    [self deallcSwizzle];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)endEdit{
    if (self.navigationController) {
        [self.navigationController.view endEditing:YES];
    }else{
        [self.view endEditing:YES];
    }
}


@end






