//
//  Task.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGTaskStep.h"

typedef enum{
    TriggerTypeTalk,
    TriggerTypeEnterArea,
    TriggerTypeUndefined
}TriggerType;

typedef enum{
    TaskRequirementTypeNone
}TaskRequirementType;

@interface RPGTask : NSObject {
    NSString *_id;
    NSString *_taskName;
    NSString *_requirement;
    
    TriggerType _triggerType;
    NSString *_triggerNPCId;
    
    TaskRequirementType _requirementType;
    
    NSArray *_stepArray;
}

@property(nonatomic, readonly)NSString *taskName;

- (id)initWithTaskId:(NSString *)taskId;
- (RPGTaskStep *)currentStep;
- (BOOL)canTriggerByTalkToNPC:(NSString *)npcId;
- (void)resetAllStep;

@end
