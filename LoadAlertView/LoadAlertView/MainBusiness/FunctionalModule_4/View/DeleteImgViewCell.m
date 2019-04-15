//
//  DeleteImgViewCell.m
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "DeleteImgViewCell.h"

#define showPageLabelWIDTH  50
#define showPageLabelHEIGHT 25

@interface DeleteImgViewCell()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex;

//以下两个二选一
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, retain) UILabel * showPageLabel;

@end

@implementation DeleteImgViewCell

- (UILabel *)showPageLabel{
    if (!_showPageLabel) {
        _showPageLabel = [[UILabel alloc] initWithFrame:CGRectMake((UIWINDOW_WIDTH - showPageLabelWIDTH)/2, UIWINDOW_HEIGHT - Height_TabBar + 5, showPageLabelWIDTH, showPageLabelHEIGHT)];
        _showPageLabel.textAlignment = NSTextAlignmentCenter;
        _showPageLabel.backgroundColor = [UIColor whiteColor];
        _showPageLabel.layer.cornerRadius = 5;
        _showPageLabel.clipsToBounds = true;
        [self addSubview:_showPageLabel];
    }
    return _showPageLabel;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH / 2, 30)];
        _pageControl.center = CGPointMake(UIWINDOW_WIDTH / 2, UIWINDOW_HEIGHT - Height_TabBar + 5);
        [self addSubview:_pageControl];
        //可以开放属性
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    }
    return _pageControl;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initWithImgDataArray:(NSArray *)dataArray index:(NSInteger)index{
    
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH, UIWINDOW_HEIGHT)];
    gui.delegate = self;
    gui.pagingEnabled = YES;
    gui.backgroundColor = [UIColor darkTextColor];
    // 隐藏滑动条
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    
    // 取消反弹
    gui.bounces = NO;
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        //UIViewContentModeScaleAspectFit
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWINDOW_WIDTH * i, Height_NavBar,UIWINDOW_WIDTH, UIWINDOW_HEIGHT - Height_NavBar - Height_TabBar)];
        imageView.userInteractionEnabled = true;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 2000;
        [gui addSubview:imageView];
        
        if ([dataArray[i] isKindOfClass:[UIImage class]])
            [imageView setImage:dataArray[i]];
        else
            [imageView sd_setImageWithURL:dataArray[i] placeholderImage:[UIImage imageNamed:@"01"]];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissBack)];
        [imageView addGestureRecognizer:tap];
    }
    gui.contentSize = CGSizeMake(UIWINDOW_WIDTH * dataArray.count, 0);
    [self addSubview:gui];
    
    UIButton *btn = [ICEUIFactory initButtonWithFrame:CGRectMake(UIWINDOW_WIDTH - 80,Height_StatusBar + 5, 60, 35) bgColor:[UIColor redColor] title:@"删除" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] cornerRadius:5 target:self action:@selector(buttonClick:)];
    [self addSubview:btn];

    _currentIndex = index;
    if (_type == showPageControlType) {
        self.pageControl.numberOfPages = dataArray.count;
        self.pageControl.currentPage = index;
    }else{
       [self.showPageLabel setText:[NSString stringWithFormat:@"%zd / 9",index+1]];
    }
    [gui setContentOffset:CGPointMake(UIWINDOW_WIDTH * index,0) animated:false];
}

- (void) buttonClick:(UIButton *) sender
{
    [self disMissBack];
    if (_delteImgCallBack) {
        _delteImgCallBack(_currentIndex);
    }
}

- (void) disMissBack
{
    [self removeFromSuperview];
}

#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / UIWINDOW_WIDTH;
    if (_type == showPageControlType)
         self.pageControl.currentPage = _currentIndex;
    else
        [self.showPageLabel setText:[NSString stringWithFormat:@"%zd / 9",_currentIndex+1]];
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
