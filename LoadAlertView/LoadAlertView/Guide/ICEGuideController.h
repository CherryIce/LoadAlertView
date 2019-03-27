//
//  ICEGuideController.h
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ICEGuideSelectDelegate <NSObject>

- (void) clickEnter;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ICEGuideController : UIViewController

@property (nonatomic, strong) UIButton *btnEnter;

// 初始化引导页
- (void)guidePageControllerWithImages:(NSArray *)images;

+ (BOOL)isShow;

@property (nonatomic, assign) id<ICEGuideSelectDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
