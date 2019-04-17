//
//  ClassificationViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/4/15.
//  Copyright © 2019 doman. All rights reserved.
//

#import "ClassificationViewController.h"

#import "TableRefreshViewController.h"

@interface ClassificationViewController ()<TYTabPagerControllerDataSource,TYTabPagerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *titleDatas;

@end

@implementation ClassificationViewController

- (NSMutableArray *)titleDatas{
    if (!_titleDatas) {
        _titleDatas = [NSMutableArray array];
    }
    return _titleDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"标签页";
    self.tabBarHeight = 50;
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    //self.tabBar.layout.cellWidth = CGRectGetWidth(self.view.frame)/3;
    self.tabBar.layout.cellSpacing = 10;
    self.tabBar.layout.cellEdging = 10;
    self.tabBar.layout.progressWidth = 30;
    self.tabBar.layout.adjustContentCellsCenter = YES;
    self.dataSource = self;
    self.delegate = self;
    
    [self loadData];
}

- (void)loadData {
    [self.titleDatas removeAllObjects];
    
    [self.titleDatas addObjectsFromArray:@[@"第一页",@"第二栏",@"第三项",@"第四选",@"第五手"]];
    
    // only add controller at index 1
    [self scrollToControllerAtIndex:1 animate:YES];
    [self reloadData];
    
    // first reloadData add controller at index 0,and scroll to index 1
    //    [self reloadData];
    //    [self scrollToControllerAtIndex:1 animate:YES];
}

#pragma mark - TYTabPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController {
    return self.titleDatas.count;
}

- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    NSArray * colorArr = @[[UIColor redColor],[UIColor orangeColor],[UIColor blackColor],[UIColor greenColor],[UIColor lightGrayColor]];
    TableRefreshViewController * ctl = [[TableRefreshViewController alloc] init];
    ctl.refreshColor = colorArr[index];
    ctl.refreshStyle = index;
    return ctl;
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
    NSString *title = self.titleDatas[index];
    return title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
