//
//  ICEToolsHelper.m
//  LoadAlertView
//
//  Created by doman on 2019/3/26.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEToolsHelper.h"

@implementation ICEToolsHelper

/** 是否为空 **/
+ (BOOL)isEmpty:(id)value
{
    if ([value isKindOfClass:[NSNull class]] || value == nil) {
        return true;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value isEqualToString:@""] || [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
    }
    else if ([value isKindOfClass:[NSArray class]]) {
        return [(NSArray *)value count] == 0;
    }
    else if ([value isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)value count] == 0;
    }
    return false;
}

/** 字典转jsonstring **/
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
