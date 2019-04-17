//
//  ICEBaseModel.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseModel.h"

@implementation ICEBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self mj_setKeyValues:dic];
    }
    return self;
}

@end
