//
//  ICETabBarController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICETabBarController.h"

#import "ICENavigationController.h"

#import "ICEModule1ViewController.h"
#import "ICEModule2ViewController.h"
#import "ICEModule3ViewController.h"
#import "ICEModule4ViewController.h"
#import "ICEModule5ViewController.h"

@interface ICETabBarController ()

@end

@implementation ICETabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewController:[[ICEModule1ViewController alloc] init] navTitle:APPNAME tabbarTitle:@"one" tabbarImage:@"2"];
    [self addChildViewController:[[ICEModule2ViewController alloc] init] navTitle:@"AAA" tabbarTitle:@"two" tabbarImage:@"4"];
    [self addChildViewController:[[ICEModule3ViewController alloc] init] navTitle:@"ZZZ" tabbarTitle:@"three" tabbarImage:@"5"];
    [self addChildViewController:[[ICEModule4ViewController alloc] init] navTitle:@"AAA" tabbarTitle:@"two" tabbarImage:@"4"];
    [self addChildViewController:[[ICEModule5ViewController alloc] init] navTitle:@"ZZZ" tabbarTitle:@"three" tabbarImage:@"5"];

}

- (void)addChildViewController:(UIViewController *)controller navTitle:(NSString *)navTitle tabbarTitle:(NSString *)tabbarTitle tabbarImage:(NSString *)tabbarImage{
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorHex(999999);
    selectTextAttrs[NSForegroundColorAttributeName] = UIColorHex(707070);
    [controller.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    ICENavigationController *nav = [[ICENavigationController alloc]initWithRootViewController:controller];
    controller.navigationItem.title = navTitle;
    controller.tabBarItem.title = tabbarTitle;
    controller.tabBarItem.image = [[UIImage imageNamed:tabbarImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage= [[UIImage imageNamed:[NSString stringWithFormat:@"%@s",tabbarImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
