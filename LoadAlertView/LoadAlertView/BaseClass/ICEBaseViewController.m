//
//  ICEBaseViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseViewController.h"

@interface ICEBaseViewController ()

@end

@implementation ICEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认都是第一次加载 也可以在viewWillAppear里面,但是必须调用者方法才可以
    self.isFirst = true;
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
