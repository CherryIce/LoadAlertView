//
//  DeleteImgViewCell.h
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseTableViewCell.h"

typedef enum : NSUInteger {
    showPageControlType,
    showPageLabelType
} showAlertTyPe;

NS_ASSUME_NONNULL_BEGIN

@interface DeleteImgViewCell : ICEBaseTableViewCell

- (void)initWithImgDataArray:(NSArray *)dataArray index:(NSInteger)index;

@property (nonatomic,copy) void (^delteImgCallBack)(NSInteger tag);

@property (nonatomic,assign) showAlertTyPe type;

@end

NS_ASSUME_NONNULL_END
