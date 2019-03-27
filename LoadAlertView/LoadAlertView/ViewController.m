//
//  ViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   UIButton * button =  [ICEUIFactory initButtonWithFrame:CGRectMake(UIWINDOW_WIDTH/2 - 50, UIWINDOW_HEIGHT/2 - 20, 100, 40) bgColor:[UIColor lightGrayColor] title:@"测试数据" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] cornerRadius:5 target:self action:@selector(buttonClick:)];
    [self.view addSubview:button];
}

- (void)buttonClick:(id)sender {
    //@"http://qzone-music.qq.com/fcg-bin/cgi_playlist_xml.fcg?uin=406859116&json=1&g_tk=1916754934"
    //@"http://cache.video.iqiyi.com/jp/avlist/202861101/1/?callback=jsonp9"
    [[APIRequest sharedNewtWorkTool] GETRequestWithUrl:@"http://qzone-music.qq.com/fcg-bin/cgi_playlist_xml.fcg?uin=406859116&json=1&g_tk=1916754934" paramaters:nil successBlock:^(NSDictionary * _Nonnull data) {
        NSLog(@">>>>>\ndata:%@",data);
    } FailBlock:^(NSError * _Nonnull error) {
        
    }];
}




@end
