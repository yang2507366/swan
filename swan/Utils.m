//
//  Utils.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)readValueByKey:(NSString *)key src:(NSString *)src
{
    key = [NSString stringWithFormat:@"#%@=", key];
    NSRange rangeBegin = [src rangeOfString:key];
    if (rangeBegin.location != NSNotFound) {
        rangeBegin.location += [key length];
        rangeBegin.length = [src length] - rangeBegin.location;
        NSRange rangeEnd = [src rangeOfString:@"##" options:NSCaseInsensitiveSearch range:rangeBegin];
        if (rangeEnd.location != NSNotFound) {
            return [[src substringWithRange:NSMakeRange(rangeBegin.location, rangeEnd.location - rangeBegin.location)] 
                    stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
    }
    return nil;
}

+ (NSString *)readAttributeByKey:(NSString *)key src:(NSString *)src
{
    key = [NSString stringWithFormat:@"%@=", key];
    NSRange rangeBegin = [src rangeOfString:key];
    if (rangeBegin.location != NSNotFound) {
        rangeBegin.location += [key length];
        rangeBegin.length = [src length] - rangeBegin.location;
        NSRange rangeEnd = [src rangeOfString:@"," options:NSCaseInsensitiveSearch range:rangeBegin];
        if (rangeEnd.location != NSNotFound) {
            return [[src substringWithRange:NSMakeRange(rangeBegin.location, rangeEnd.location - rangeBegin.location)] 
                    stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
    }
    return nil;
}

+ (NSArray *)readValueListByKey:(NSString *)key src:(NSString *)src
{
    NSString *body = [Utils readValueByKey:key src:src];
    if (body != nil) {
        NSArray *array = [body componentsSeparatedByString:@";"];
        NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
        for(NSString *item in array){
            if (![[item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
                [returnArray addObject:item];
            }
        }
        return returnArray;
    }
    return nil;
}

@end
