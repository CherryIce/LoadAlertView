//
//  DeleteImgViewCell.h
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeleteImgViewCell : ICEBaseTableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

- (void)initWithImgDataArray:(NSArray *)dataArray;

@property (nonatomic,copy) void (^delteImgCallBack)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
