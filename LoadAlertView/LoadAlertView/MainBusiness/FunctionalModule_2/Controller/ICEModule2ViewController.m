//
//  ICEModule2ViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEModule2ViewController.h"

#import "ICEAreaPickView.h"

@interface ICEModule2ViewController ()

@property (nonatomic,strong) ICEAreaPickView * pickView;


@end

@implementation ICEModule2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurationUI];
}

/**
 搭UI
 */
- (void) configurationUI
{
    UIButton * videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoBtn setFrame:CGRectMake(UIWINDOW_WIDTH/2 - 30, Height_NavBar + 70, 60, 60)];
    [videoBtn setBackgroundColor:[UIColor blackColor]];
    videoBtn.tag = 10;
    [videoBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoBtn];
}

- (void)buttonClick
{
    [_pickView removeFromSuperview];

    _pickView = nil;
    _pickView = [[ICEAreaPickView alloc] initWithFrame:CGRectZero];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_pickView];
    
    _pickView.selectProvinceCityAreaCall = ^(NSString *province, NSString * city, NSString * area, NSInteger aId) {
        //可以将省市区换了,然后将_model.full_district换了
        NSString * text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        [MBProgressHUD showMessage:text];
        //ID需要上传给后台
        
    };
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
