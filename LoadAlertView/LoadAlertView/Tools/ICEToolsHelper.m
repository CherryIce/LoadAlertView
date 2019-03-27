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

@end
