//
//  MBProgressHUD+Simple.h
//  LoadAlertView
//
//  Created by doman on 2019/4/17.
//  Copyright © 2019 doman. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Simple)

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(nullable UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(nullable UIView *)view;
+ (void)showError:(NSString *)error toView:(nullable UIView *)view;
+ (void)showWarning:(NSString *)Warning toView:(nullable UIView *)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(nullable UIView *)view;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(nullable UIView *)view;
+ (MBProgressHUD *)showProgressBarToView:(nullable UIView *)view;


#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(nullable UIView *)view;
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
