//
//  Scene.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "NPC.h"
#import "Monster.h"

@interface Scene : NSObject {
    NSString *_title;
    NSString *_id;
    NSArray *_taskArray;
    NSArray *_npcArray;
    NSArray *_monsterArray;
}

@property(nonatomic, readonly)NSString *title;
@property(nonatomic, readonly)NSString *sceneId;
@property(nonatomic, readonly)NSArray *npcArray;
@property(nonatomic, readonly)NSArray *monsterArray;

- (id)initWithScriptName:(NSString *)scriptFile;
- (Task *)getTaskByTalkToNPC:(NSString *)npc;

@end
