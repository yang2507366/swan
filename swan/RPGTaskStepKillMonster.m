//
//  StepKillMonster.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RPGTaskStepKillMonster.h"
#import "Utils.h"

@implementation RPGTaskStepKillMonster

@synthesize killedCount = _killedCount;
@synthesize needAmount = _needAmount;

- (id)initTaskStepWithAttribute:(NSString *)attr
{
    self = [super initTaskStepWithAttribute:attr];
    if (self) {
        // Initialization code here.
        _monsterId = [Utils readAttributeByKey:@"TARGET" src:attr];
        _needAmount = [[Utils readAttributeByKey:@"AMOUNT" src:attr] intValue];
        _killedCount = 0;
        //NSLog(@"stepKillMonster monsterId:%@ amount:%d", _monsterId, _needAmount);
    }
    
    return self;
}

- (void)reset
{
    _killedCount = 0;
}

- (void)dealloc
{
    [_monsterId release];
    [super dealloc];
}

@end
