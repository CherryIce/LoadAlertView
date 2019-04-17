//
//  TableRefreshViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/4/17.
//  Copyright © 2019 doman. All rights reserved.
//

#import "TableRefreshViewController.h"

@interface TableRefreshViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * dataArr;



@end

@implementation TableRefreshViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [ICEUIFactory initTableViewWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH, UIWINDOW_HEIGHT - 50 - Height_NavBar) style:UITableViewStylePlain delegate:self];
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self loadData];
    
    ICEWeakSelf;
    [self.tableView bindHeadRefreshHandler:^{
        [weakSelf loadData];
    } themeColor:_refreshColor refreshStyle:_refreshStyle];
    
    [self.tableView bindFootRefreshHandler:^{
        [weakSelf loadMore];
    } themeColor:_refreshColor refreshStyle:_refreshStyle];
}

#pragma mark 下拉刷新
- (void) loadData{
    [self.dataArr removeAllObjects];
    if (self.isFirst) {
        [MBProgressHUD showActivityMessage:@"加载中..."];
    }
    for (int i = 0; i<30; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"%03d",i]];
    }
    ICEWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.isFirst) {
            [MBProgressHUD hideHUD];
            weakSelf.isFirst = false;
        }
        [self.tableView.headRefreshControl endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma mark  ====== 上拉加载 ======
- (void) loadMore{
    for (int i = 0; i<30; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"%03d",i]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.footRefreshControl endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma mark  ###### tableView #####
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
