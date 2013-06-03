//
//  StepTalk.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TaskStep.h"

@interface StepTalk : TaskStep {
    NSString *_dialogId;
    NSArray *_dialogArray;
}

@property(nonatomic, readonly)NSArray *dialogArray;

@end
