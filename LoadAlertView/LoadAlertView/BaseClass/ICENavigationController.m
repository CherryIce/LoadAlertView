//
//  ICENavigationController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICENavigationController.h"

@interface ICENavigationController ()

// 记录push标志
@property (nonatomic, getter=isPushing) BOOL pushing;

@end

@implementation ICENavigationController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //重新设置侧滑手势的代理
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
}

//开始接收到手势的代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断是否是侧滑相关的手势
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // 如果当前展示的控制器是根控制器就不让其响应
        if (self.viewControllers.count < 2 ||
            self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}

//接收到多个手势的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 判断是否是侧滑相关手势
    if (gestureRecognizer == self.interactivePopGestureRecognizer && [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self.view];
        // 如果是侧滑相关的手势，并且手势的方向是侧滑的方向就让多个手势共存
        if (point.x > 0) {
            return YES;
        }
    }
    return NO;
}


//-------------------------------------------------------------------------------------
//----------  防重push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.pushing == YES) {
        NSLog(@"被拦截");
        //return;
    } else {
        NSLog(@"push");
        self.pushing = YES;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}
//----------  防重push
//-------------------------------------------------------------------------------------


@end
