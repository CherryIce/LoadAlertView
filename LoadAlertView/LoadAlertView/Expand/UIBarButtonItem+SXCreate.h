//
//  UIBarButtonItem+SXCreate.h
//  LoadAlertView
//
//  Created by doman on 2019/4/15.
//  Copyright © 2019 doman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UINavigationItem+SXFixSpace.h"
#import "UINavigationController+SXFixSpace.h"
#import "UINavigationBar+SXFixSpace.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (SXCreate)

/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(nullable UIImage *)image;
/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(nullable UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param nomalImage nomalImage
 @param higeLightedImage higeLightedImage
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(nullable UIImage *)nomalImage
                  higeLightedImage:(nullable UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;


/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title title
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title title
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title title
 @param font font
 @param titleColor 字体颜色
 @param highlightedColor 高亮颜色
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(nullable UIFont *)font
                        titleColor:(nullable UIColor *)titleColor
                  highlightedColor:(nullable UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;


/**
 用作修正位置的UIBarButtonItem
 
 @param width 修正宽度
 @return 修正位置的UIBarButtonItem
 */
+(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
