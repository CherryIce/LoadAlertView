//
//  APIRequest.m
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "APIRequest.h"

@implementation APIRequest

+ (instancetype)sharedNewtWorkTool
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//　　3.封装方法参数说明:
//
//　　　   (1)urlString:登录接口字符串
//
//　　　　 (2)paramaters:请求参数字典   key:服务器提供的接收参数的key. value:参数内容
//
//　　　　 (3)typedef void(^SuccessBlock)(id object , NSURLResponse *response):成功后回调的block :参数: 1. id: object(如果是 JSON ,那么直接解析   　　成OC中的数组或者字典.如果不是JSON ,直接返回 NSData) 2. NSURLResponse: 响应头信息，主要是对服务器端的描述
//
//　　　　 (4)typedef void(^failBlock)(NSError *error):失败后回调的block:参数: 1.error：错误信息，如果请求失败，则error有值
//
//GET请求方法封装:
- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(nullable NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(FailureBlock)fail
{
    // 1. 创建请求.
    
    // 参数拼接.
    
    // 遍历参数字典,一一取出参数,按照参数格式拼接在 url 后面.
    
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 服务器接收参数的 key 值.
        NSString *paramaterKey = key;
        
        // 参数内容
        NSString *paramaterValue = obj;
        
        // appendFormat :可变字符串直接拼接的方法!
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
    
    // 截取字符串的方法!
    urlString = [urlString substringToIndex:urlString.length - 1];
    
    NSLog(@"urlString:%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    // 2. 发送网络请求.
    // completionHandler: 说明网络请求完成!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //NSLog(@"xxxx%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *result = [[NSString alloc] initWithData:data encoding:encode];
        
        //NSString *str =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        printf("请求返回\n%s\n------------------------------------------------------------------------------------------------\n\n\n ",[result UTF8String]);
        
        
        // 网络请求成功:
        if (data && !error) {
            
            // 查看 data 是否是 JSON 数据.
            
            // JSON 解析.
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            
            // 如果 obj 能够解析,说明就是 JSON
            if (!obj) {
                obj = data;
            }
            
            // 成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    success(obj);
                }
            });
            
        }else //失败
        {
            // 失败回调
            if (fail) {
                fail(error);
            }
        }
        
    }] resume];
}


//POST请求方法封装:
- (void)POSTRequestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(FailureBlock)fail
{
    // 1. 创建请求.
    
    // 参数拼接.
    // 遍历参数字典,一一取出参数
    
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 服务器接收参数的 key 值.
        NSString *paramaterKey = key;
        
        // 参数内容
        NSString *paramaterValue = obj;
        
        // appendFormat :可变字符串直接拼接的方法!
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    
    NSString *body = [strM substringToIndex:strM.length - 1];
    
    NSLog(@"%@",body);
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    // 1.设置请求方法:
    request.HTTPMethod = @"POST";
    
    // 2.设置请求体
    request.HTTPBody = bodyData;
    
    // 2. 发送网络请求.
    // completionHandler: 说明网络请求完成!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        
        // 网络请求成功:
        if (data && !error) {
            
            // 查看 data 是否是 JSON 数据.
            
            // JSON 解析.
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            // 如果 obj 能够解析,说明就是 JSON
            if (!obj) {
                obj = data;
            }
            
            // 成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    success(obj);
                }
            });
            
        }else //失败
        {
            // 失败回调
            if (fail) {
                fail(error);
            }
        }
        
    }] resume];
    
}

// 原生上传图片
- (void) postImageWithBaseApi:(NSString *)baseApi AndPragram:(NSDictionary *)pragram updatImage:(UIImage *)image Completion:(void (^) (id obj))completion
{
    
    if (!image) {
        return;
    }
    
    NSString *sep = @"ABFC134";
    
    //    1:创建ULR
    NSURL *url = [NSURL URLWithString:baseApi];
    
    //    2:创建Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //    3:设置相关属性
    
    //        3.1设置请求方式
    [request setHTTPMethod:@"POST"];
    
    
    //          3.2处理基本参数(不含图片)
    
    NSArray *allKeys = [pragram allKeys];
    
    NSMutableString *bodyString = [NSMutableString string];
    
    for (NSString *key in allKeys)
    {
        [bodyString appendFormat:@"--%@\r\n",sep];
        
        NSString *temStr = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",key,pragram[key]];
        [bodyString appendString:temStr];
        //        NSLog(@"%@",bodyString);
        
    }
    
    //          3.3拼上图片
    [bodyString appendFormat:@"--%@\r\n",sep];
    
    NSString *imageDes = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n"];
    [bodyString appendString:imageDes];
    
    
    NSString *imageType = [NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"];
    [bodyString appendString:imageType];
    
    //    3.4将图片转换成二进制
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //    3.5往bodyString中加入图片
    //        3.5.1先将bodyString转成二进制
    NSMutableData *bodyData = [NSMutableData dataWithData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [bodyData appendData:imageData];
    
    //    4追加结束标示
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--",sep];
    [bodyData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //    5:设置请求体
    [request setHTTPBody:bodyData];
    
    //6:设置request的value中content－type
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",sep] forHTTPHeaderField:@"Content-Type"];
    
    //    7:设置请求体的长度
    [request setValue:[NSString stringWithFormat:@"%ld",bodyData.length] forHTTPHeaderField:@"Content-Length"];
    
    //    8:设置超时
    [request setTimeoutInterval:30.0f];
    
    // 2. 发送网络请求.
    // completionHandler: 说明网络请求完成!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        
        // 网络请求成功:
        if (data && !error) {
            
            // 查看 data 是否是 JSON 数据.
            
            // JSON 解析.
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            // 如果 obj 能够解析,说明就是 JSON
            if (!obj) {
                obj = data;
            }
            
            // 成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(obj);
            });
            
        }else //失败
        {
            completion(error);
        }
        
    }] resume];
}


@end
