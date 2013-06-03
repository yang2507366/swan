//
//  TaskStep.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TaskStepTypeTalk,
    TaskStepTypeKillMonster,
    TaskStepTypeUnknown
}TaskStepType;

@interface TaskStep : NSObject {
    BOOL _done;
    TaskStepType _type;
    NSString *_targetId;
}

@property(nonatomic, assign)BOOL isDone;
@property(nonatomic, readonly)TaskStepType type;
@property(nonatomic, readonly)NSString *targetId;

- (id)initTaskStepWithAttribute:(NSString *)attr;

+ (TaskStepType)getTaskTypeByAttribute:(NSString *)attr;

@end
