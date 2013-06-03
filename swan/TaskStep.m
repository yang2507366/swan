//
//  TaskStep.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TaskStep.h"
#import "Utils.h"

@implementation TaskStep

@synthesize isDone = _done;
@synthesize type = _type;
@synthesize targetId = _targetId;

- (id)initTaskStepWithAttribute:(NSString *)attr
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _type = [TaskStep getTaskTypeByAttribute:attr];
        _targetId = [[Utils readAttributeByKey:@"TARGET" src:attr] retain];
        _done = NO;
    }
    
    return self;
}

+ (TaskStepType)getTaskTypeByAttribute:(NSString *)attr
{
    NSString *type = [Utils readAttributeByKey:@"TYPE" src:attr];
    if ([type isEqualToString:@"TALK"]) {
        return TaskStepTypeTalk;
    }else if([type isEqualToString:@"KILL_MONSTER"]){
        return TaskStepTypeKillMonster;
    }
    return TaskStepTypeUnknown;
}

- (void)dealloc
{
    [_targetId release];
    [super dealloc];
}

@end
