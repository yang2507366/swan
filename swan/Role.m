//
//  Role.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Role.h"

@implementation Role

@synthesize position = _position;
@synthesize roldId = _roldId;
@synthesize type = _type;

- (id)initWithAttribute:(NSString *)attr
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSRange beginRange = [attr rangeOfString:@"("];
        if (beginRange.location != NSNotFound) {
            _roldId = [[attr substringToIndex:beginRange.location] retain];
            NSString *positionInfo = [attr substringFromIndex:beginRange.location];
            positionInfo = [positionInfo stringByReplacingOccurrencesOfString:@"(" withString:@""];
            positionInfo = [positionInfo stringByReplacingOccurrencesOfString:@")" withString:@""];
            NSArray *positionArray = [positionInfo componentsSeparatedByString:@","];
            NSString *x = [[positionArray objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *y = [[positionArray objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            _position.x = [x floatValue];
            _position.y = [y floatValue];
            
            //NSLog(@"init role:%@ position:%f, %f", _roldId, _position.x, _position.y);
        }
    }
    
    return self;
}

- (void)dealloc
{
    [_id release];
    [super dealloc];
}

@end
