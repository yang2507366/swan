//
//  AnimationUtils.m
//  DD
//
//  Created by yangzexin on 11-8-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AnimationUtils.h"
#import "Utils.h"

@implementation AnimationUtils

+ (CGRect)getAnimationRect:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray *valueList = [str componentsSeparatedByString:@","];
    int x = 0;
    int y = 0;
    int width = 0;
    int height = 0;
    
    for(NSInteger i = 0, j = 0; i < [valueList count]; ++i){
        NSString *item = [[valueList objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (![item isEqualToString:@""]) {
            if (j == 0) {
                x = [item intValue];
            }else if(j == 1){
                y = [item intValue];
            }else if(j == 2){
                width = [item intValue];
            }else if(j == 3){
                height = [item intValue];
            }
            ++j;
        }
    }
    return CGRectMake(x, y, width, height);
}

+ (void)cacheAnimation:(NSString *)animationName
{
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.frames", animationName]];
    NSString *info = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *valueList = [Utils readValueListByKey:@"Frames" src:info];
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CCTexture2D *texture = [[CCTexture2D alloc] initWithCGImage:[UIImage imageNamed:[Utils readValueByKey:@"ImageSource" src:info]].CGImage resolutionType:kCCResolutioniPhone];
    for(NSString *valueItem in valueList){
        CGRect rect = [self getAnimationRect:valueItem];
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:rect];
        [frames addObject:frame];
    }
    CCAnimation *anim = [CCAnimation animationWithFrames:frames];
    anim.delayPerUnit = 0.1;
    [frames release];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animationName];
}

@end
