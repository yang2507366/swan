//
//  AnimationUtils.h
//  DD
//
//  Created by yangzexin on 11-8-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AnimationUtils : NSObject

+ (CGRect)getAnimationRect:(NSString *)str;
+ (void)cacheAnimation:(NSString *)animationName;

@end
