//
//  APIRequest.h
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);

@interface APIRequest : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

+ (instancetype)sharedNewtWorkTool;

//GET请求方法封装:
- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(nullable NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(FailureBlock)fail;

//POST请求方法封装:
- (void)POSTRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(FailureBlock)fail;

// 原生上传图片
- (void) postImageWithBaseApi:(NSString *)baseApi AndPragram:(NSDictionary *)pragram updatImage:(UIImage *)image Completion:(void (^) (id obj))completion;

@end

NS_ASSUME_NONNULL_END
