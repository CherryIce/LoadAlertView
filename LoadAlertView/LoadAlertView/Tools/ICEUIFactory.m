//
//  ICEUIFactory.m
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEUIFactory.h"

@implementation ICEUIFactory

+ (UITableView *) initTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = delegate;
    tableView.delegate   = delegate;
    if (@available(iOS 11.0, *)) {
        tableView.estimatedRowHeight = 100;//预防mj上拉多次刷新
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}


+ (UIButton *) initButtonWithFrame:(CGRect) frame bgColor:(UIColor *) bgColor title:(NSString *)title titleColor:(nullable UIColor * ) titleColor font:(nullable UIFont *) font  cornerRadius:(CGFloat)cornerRadius  target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    button.layer.cornerRadius = cornerRadius;
    [button setBackgroundColor:bgColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:true];
    return button;
}

@end
