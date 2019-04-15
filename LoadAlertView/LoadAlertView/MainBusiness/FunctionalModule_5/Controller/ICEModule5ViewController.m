//
//  ICEModule5ViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEModule5ViewController.h"
#import "ClassificationViewController.h"

#define BAI 100
#define PADDING 10

@interface ICEModule5ViewController ()

@property (nonatomic,strong) UIView * v;

@end

@implementation ICEModule5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void) initUI
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(UIWINDOW_WIDTH/2-BAI/2, Height_NavBar + PADDING, BAI, BAI)];
    [button addTarget:self action:@selector(chageRandom:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:button];
}

- (void) chageRandom:(UIButton *)sender
{
    int a = (arc4random() % 9) + 1;;
    
    NSMutableArray * dataArr = [NSMutableArray array];
    
    for (int i = 0; i < a; i++) {
        [dataArr addObject:@"x"];
    }
    
    [self initWithImageArrLists:[dataArr copy]];
}

- (void) initWithImageArrLists:(NSArray *)imgArrLists
{
    
    NSLog(@">>>>>>>>%zd",imgArrLists.count);
    
    [_v removeFromSuperview];
    
    _v = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar + 2 * PADDING + BAI, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    [self.view addSubview:_v];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/3;
    switch (imgArrLists.count) {
        case 1:
        {
            //等比例大小
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(PADDING, PADDING, width - PADDING, width - PADDING)];
            button.backgroundColor = [UIColor greenColor];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDragInside];
            [_v addSubview:button];
        }
            break;
        case 2:
        case 4:
        {
            //两列,不确定行
            for(int i = 0; i <  imgArrLists.count / 2; i++)
            {
                for(int j = 0; j < 2 ; j++)
                {
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button setFrame:CGRectMake(j*width + PADDING, i*width + PADDING, width - PADDING, width - PADDING)];
                    button.backgroundColor = [UIColor redColor];
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDragInside];
                    [_v addSubview:button];
                }
            }
        }
            break;
        case 3:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        {
            //三列,不确定行
            CGFloat num = 1 + imgArrLists.count / 3;
            for(int i = 0; i < num; i++)
            {
                for(int j = 0; j < 3 ; j++)
                {
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    if (i == num - 1 && j >= imgArrLists.count % 3){
                        break;
                    }
                    [button setFrame:CGRectMake(j*width + PADDING, i*width + PADDING, width - PADDING, width - PADDING)];
                    button.backgroundColor = [UIColor purpleColor];
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDragInside];
                    [_v addSubview:button];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void) buttonClick:(UIButton *) sender
{
    //classification
    ClassificationViewController * ctl = [[ClassificationViewController alloc] init];
    [self.navigationController pushViewController:ctl animated:false];
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
