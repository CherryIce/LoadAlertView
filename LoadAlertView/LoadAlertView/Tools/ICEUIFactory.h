//
//  ICEUIFactory.h
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEUIFactory : NSObject

/**
 //常规属性
 frame
 style
 delegate
 
 //ios11设置属性
 etimatedRowHeight
 etimatedSectionHeaderHeight
 etimatedSectionFootererHeight
 */
+ (UITableView *) initTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate;
/**>
 *   cornerRadius = hs/2; //圆角
 Frame
 BackgroundColor
 Title
 TitleColor
 font
 [nextBut addTarget:self action:@selector(saveRoom) forControlEvents:UIControlEventTouchUpInside];
 */
+ (UIButton *) initButtonWithFrame:(CGRect) frame bgColor:(UIColor *) bgColor title:(NSString *)title titleColor:(nullable UIColor * ) titleColor font:(nullable UIFont *) font  cornerRadius:(CGFloat)cornerRadius  target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
