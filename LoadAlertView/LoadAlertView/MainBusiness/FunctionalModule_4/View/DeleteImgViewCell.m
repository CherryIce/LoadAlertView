//
//  DeleteImgViewCell.m
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "DeleteImgViewCell.h"

@implementation DeleteImgViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initWithImgDataArray:(NSArray *)dataArray{
    
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH, UIWINDOW_HEIGHT)];
    gui.delegate = self;
    gui.pagingEnabled = YES;
    // 隐藏滑动条
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    
    // 取消反弹
    gui.bounces = NO;
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(UIWINDOW_WIDTH * i, Height_NavBar,UIWINDOW_WIDTH, UIWINDOW_HEIGHT - Height_NavBar - Height_TabBar);
        [button setAdjustsImageWhenHighlighted:false];
        [button setBackgroundColor:[UIColor blueColor]];
        //[button setBackgroundImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateNormal];
        button.tag = 2000;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [gui addSubview:button];
    }
    gui.contentSize = CGSizeMake(UIWINDOW_WIDTH * dataArray.count, 0);
    [self addSubview:gui];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(UIWINDOW_WIDTH - 80,Height_StatusBar, 60, 40);
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH / 2, 30)];
    self.pageControl.center = CGPointMake(UIWINDOW_WIDTH / 2, UIWINDOW_HEIGHT - 95);
    [self addSubview:self.pageControl];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = dataArray.count;
}

- (void) buttonClick:(UIButton *) sender
{
    NSInteger tag = self.pageControl.currentPage;
    if (sender.tag == 2000) {
        tag = sender.tag;
    }
    if (_delteImgCallBack) {
        _delteImgCallBack(tag);
    }
}

#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / UIWINDOW_WIDTH;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
