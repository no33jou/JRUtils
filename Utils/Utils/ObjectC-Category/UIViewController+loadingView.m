//
//  UIViewController+loadingView.m
//  CrazySmallNote
//
//  Created by xzysun on 14-8-5.
//  Copyright (c) 2014年 netease. All rights reserved.
//
#define SYSTEM_DEVICEVALUE  [[UIDevice currentDevice].systemVersion floatValue]

#import "UIViewController+loadingView.h"
#import "MBProgressHUD.h"
#import "CSNotificationView.h"

@implementation UIViewController (loadingView)

-(MBProgressHUD *)showLoadingViewWithText:(NSString *)text
{
    MBProgressHUD *loadingView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:loadingView];
    loadingView.label.text = text;
    [loadingView showAnimated:YES];
    return loadingView;
}

-(void)hideAllLoadingView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)hideLoadingAfter:(NSTimeInterval)time
{
    MBProgressHUD *loadingView = [MBProgressHUD HUDForView:self.view];
    [loadingView hideAnimated:YES afterDelay:time];
}

-(void)showNoticeViewWithType:(GVSNoticeType)type Message:(NSString *)text Delay:(NSTimeInterval)delay
{
    //    if ([self isKindOfClass:NSClassFromString(@"GVSVideoPlayViewController")]) {
    //#warning 视频播放页面的消息暂时通过alertview的方式发送
    //        [self showAlertViewWithTitle:nil Message:text Delay:delay];
    //        return;
    //    }
    UIColor *tintColor = nil;
    UIImage *image = nil;
    if (type == GVSNoticeTypeNormal) {
        tintColor = [UIColor colorWithRed:0.000 green:0.6 blue:1.000 alpha:1];
        image = [CSNotificationView imageForStyle:CSNotificationViewStyleSuccess];
    } else if (type == GVSNoticeTypeSuccess) {
        tintColor = [UIColor colorWithRed:0.21 green:0.72 blue:0.00 alpha:1.0];;
        image = [CSNotificationView imageForStyle:CSNotificationViewStyleSuccess];
    } else if (type == GVSNoticeTypeError)  {
        tintColor = [UIColor redColor];;
        image = [CSNotificationView imageForStyle:CSNotificationViewStyleError];
    } else if (type == GVSNoticeTypeGaotieCustom){
        tintColor = [UIColor colorWithRed:253.0/255.0 green:237.0/255.0 blue:217.0/255.0 alpha:1.0];;
//        image = [CSNotificationView imageForStyle:CSNotificationViewStyleError];
        image = [UIImage imageNamed:@"warning"];
    }
    CSNotificationView *notificationView = [CSNotificationView notificationViewWithParentViewController:self tintColor:tintColor image:image message:text];
    if (type == GVSNoticeTypeGaotieCustom) {
        [notificationView.textLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:122.0/255.0 blue:32.0/255.0 alpha:1.0]];
//        [notificationView setGaotieCustomImage:image];
    }
    if (notificationView==nil) {
        return;
    }
    __weak CSNotificationView *weakNotificationView = notificationView;
    __weak typeof(self) weakSelf = self;
    [notificationView setVisible:YES animated:YES completion:^{
        if (weakSelf.navigationController && weakSelf.navigationController.navigationBarHidden) {
            [weakSelf.view addSubview:weakNotificationView];
        }
        if (delay > 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakNotificationView setVisible:NO animated:YES completion:nil];
            });
        }
    }];
    notificationView.tapHandler = ^{
        [weakNotificationView setVisible:NO animated:YES completion:nil];
    };
    
}

-(void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message Delay:(NSTimeInterval)delay
{
    if (title == nil) {
        title = @"";
    }
    if (delay > 0.0) {
        if (SYSTEM_DEVICEVALUE > 9 || SYSTEM_DEVICEVALUE == 9) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:NO completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
            });
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [alertView show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
            });
            
        }
    }else {
        if (SYSTEM_DEVICEVALUE >9 ||SYSTEM_DEVICEVALUE == 9) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancerAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancerAction];
            [self presentViewController:alertController animated:NO completion:nil];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }
    }

}

// 这个方法用于页面跳转，避免出现黑屏的情况。
-(void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message Delay:(NSTimeInterval)delay withFinishBlock:(finishBlock )finishBlock{
    if (title == nil) {
        title = @"";
    }
    if (delay > 0.0) {
        if (SYSTEM_DEVICEVALUE > 9 || SYSTEM_DEVICEVALUE == 9) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:NO completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:YES completion:nil];
                if (finishBlock) {
                     finishBlock();
                }
            });
            }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [alertView show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
                if (finishBlock) {
                    finishBlock();
                }
            });
        }
    }else {
        if (SYSTEM_DEVICEVALUE >9 ||SYSTEM_DEVICEVALUE == 9) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancerAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancerAction];
            [self presentViewController:alertController animated:NO completion:nil];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }
    }
    
}

@end
