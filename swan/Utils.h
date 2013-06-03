//
//  Utils.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)readValueByKey:(NSString *)key src:(NSString *)src;
+ (NSString *)readAttributeByKey:(NSString *)key src:(NSString *)src;
+ (NSArray *)readValueListByKey:(NSString *)key src:(NSString *)src;
@end
