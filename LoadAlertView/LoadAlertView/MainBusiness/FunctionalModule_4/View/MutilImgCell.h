//
//  MutilImgCell.h
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MutilImgCell : ICEBaseTableViewCell

- (void)initWithImgDataArray:(NSArray *)dataArray;

@property (nonatomic,copy) void (^imgHandleCallBack)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
