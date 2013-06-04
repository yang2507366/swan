//
//  StepKillMonster.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RPGTaskStep.h"

@interface RPGTaskStepKillMonster : RPGTaskStep {
    NSString *_monsterId;
    NSInteger _needAmount;
    NSInteger _killedCount;
}

@property(nonatomic, assign)NSInteger killedCount;
@property(nonatomic, readonly)NSInteger needAmount;
- (void)reset;
@end
