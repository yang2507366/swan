//
//  Task.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RPGTask.h"
#import "Utils.h"
#import "RPGTaskStepTalk.h"
#import "RPGTaskStepKillMonster.h"

@implementation RPGTask

@synthesize taskName = _taskName;

- (id)initWithTaskId:(NSString *)taskId
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _id = [taskId retain];
        NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", taskId]];
        NSString *taskInfo = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        if (taskInfo != nil) {
            // read triggerInfo
            NSString *triggerInfo = [Utils readValueByKey:@"trigger" src:taskInfo];
            //NSLog(@"triggerInfo:%@", triggerInfo);
            NSString *triggerType = [Utils readAttributeByKey:@"TYPE" src:triggerInfo];
            if ([triggerType isEqualToString:@"TALK_TO_NPC"]) {
                _triggerType = TriggerTypeTalk;
                _triggerNPCId = [[Utils readAttributeByKey:@"TARGET" src:triggerInfo] retain];
                //NSLog(@"trigger type:TriggerTypeTalk, target npc:%@", _triggerNPCId);
            }else{
                _triggerType = TriggerTypeUndefined;
            }
            
            // read task requirement
            NSString *requirementType = [Utils readValueByKey:@"requirement" src:taskInfo];
            //NSLog(@"requirementType:%@", requirementType);
            if ([requirementType isEqualToString:@"NONE"]) {
                _requirementType = TaskRequirementTypeNone;
            }
            
            // read task name
            NSString *taskName = [Utils readValueByKey:@"taskName" src:taskInfo];
            //NSLog(@"taskName:%@", taskName);
            _taskName = [taskName retain];
            
            // read step array
            NSString *stepInfo = [Utils readValueByKey:@"taskSteps" src:taskInfo];
            //NSLog(@"stepInfo:%@", stepInfo);
            NSArray *stepStrArray = [stepInfo componentsSeparatedByString:@";"];
            NSMutableArray *stepArray = [[NSMutableArray alloc] init];
            for(NSString *item in stepStrArray){
                if (![[item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
                    TaskStepType stepType = [RPGTaskStep getTaskTypeByAttribute:item];
                    RPGTaskStep *step = nil;
                    if (stepType == TaskStepTypeTalk) {
                        step = [[RPGTaskStepTalk alloc] initTaskStepWithAttribute:item];
                    }else if(stepType == TaskStepTypeKillMonster){
                        step = [[RPGTaskStepKillMonster alloc] initTaskStepWithAttribute:item];
                    }
                    [stepArray addObject:step];
                }
            }
            _stepArray = stepArray;
        }
    }
    
    return self;
}

- (BOOL)canTriggerByTalkToNPC:(NSString *)npcId
{
    if (_triggerType == TriggerTypeTalk) {
        // trigger type is talk to npc
        return [_triggerNPCId isEqualToString:npcId];
    }
    return NO;
}

- (RPGTaskStep *)currentStep
{
    RPGTaskStep *targetStep = nil;
    for(NSInteger i = 0; i < [_stepArray count]; ++i){
        RPGTaskStep *step = [_stepArray objectAtIndex:i];
        if (![step isDone]) {
            targetStep = step;
            break;
        }
    }
    return targetStep;
}

- (void)resetAllStep
{
    for(NSInteger i = 0; i < [_stepArray count]; ++i){
        RPGTaskStep *step = [_stepArray objectAtIndex:i];
        step.isDone = NO;
    }
}

- (void)dealloc
{
    [_id release];
    [_taskName release];
    [_requirement release];
    [_triggerNPCId release];
    [super dealloc];
}

@end
