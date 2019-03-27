//
//  ICEGuideController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEGuideController.h"

@interface ICEGuideController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ICEGuideController

- (void)guidePageControllerWithImages:(NSArray *)images
{
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH, UIWINDOW_HEIGHT)];
    gui.delegate = self;
    gui.pagingEnabled = YES;
    // 隐藏滑动条
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    
    // 取消反弹
    gui.bounces = NO;
    for (NSInteger i = 0; i < images.count; i ++) {
        [gui addSubview:({
            self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnEnter.frame = CGRectMake(UIWINDOW_WIDTH * i, 0,UIWINDOW_WIDTH, UIWINDOW_HEIGHT);
            [self.btnEnter setAdjustsImageWhenHighlighted:false];
            //setImage
            NSString * imgName = [self prejudgeIPhoneType:images[i]];
            [self.btnEnter setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];;
            self.btnEnter;
        })];
        
        if (i == images.count - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:[UIColor lightGrayColor]];
            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(UIWINDOW_WIDTH * i,UIWINDOW_HEIGHT - 50, UIWINDOW_WIDTH/3, 40);
            btn.center = CGPointMake(UIWINDOW_WIDTH / 2, UIWINDOW_HEIGHT - 60);
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
            [self.btnEnter addSubview:btn];
        }
    }
    gui.contentSize = CGSizeMake(UIWINDOW_WIDTH * images.count, 0);
    [self.view addSubview:gui];
    
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH / 2, 30)];
    self.pageControl.center = CGPointMake(UIWINDOW_WIDTH / 2, UIWINDOW_HEIGHT - 95);
    [self.view addSubview:self.pageControl];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = images.count;
}

//判断机型
- (NSString *) prejudgeIPhoneType:(NSString *) nameString
{
    NSString * str = nameString;
    if (IS_IPHONE_X) {
        str = [NSString stringWithFormat:@"%@iPhoneX",str];
    }
    if (IS_IPHONE_Xr) {
        str = [NSString stringWithFormat:@"%@iPhoneXR",str];
    }
    if (IS_IPHONE_Xs_Max) {
        str = [NSString stringWithFormat:@"%@iPhoneXMax",str];
    }
    return str;
}

- (void)clickEnter
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickEnter)]) {
        [self.delegate clickEnter];
    }
}

+ (BOOL)isShow
{
    // 读取版本信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [user objectForKey:VERSION_INFO_CURRENT];
    NSString * currentVersion = APPVERSION;
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
        [ICEGuideController saveCurrentVersion];
        return YES;
    }else
    {
        return NO;
    }
}

// 保存版本信息
+ (void)saveCurrentVersion
{
    NSString *version = APPVERSION;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:VERSION_INFO_CURRENT];
    [user synchronize];
}

#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / UIWINDOW_WIDTH;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
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
