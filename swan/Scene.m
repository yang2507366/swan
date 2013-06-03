//
//  Scene.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Scene.h"
#import "Utils.h"

@implementation Scene

@synthesize title = _title;
@synthesize sceneId = _id;
@synthesize npcArray = _npcArray;
@synthesize monsterArray = _monsterArray;

- (id)initWithScriptName:(NSString *)scriptFile
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:scriptFile];
        NSString *sceneInfo = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        _title = [[Utils readValueByKey:@"title" src:sceneInfo] retain];
        _id = [[Utils readValueByKey:@"id" src:sceneInfo] retain];
        
        // init npc list
        NSArray *npcValueList = [Utils readValueListByKey:@"npcs" src:sceneInfo];
        NSMutableArray *npcArray = [[NSMutableArray alloc] init];
        for(NSString *item in npcValueList){
            NPC *npc = [[NPC alloc] initWithAttribute:item];
            [npcArray addObject:npc];
            [npc release];
        }
        _npcArray = npcArray;
        
        // init monster list
        NSArray *monsterValueList = [Utils readValueListByKey:@"monsters" src:sceneInfo];
        NSMutableArray *monsterArray = [[NSMutableArray alloc] init];
        for(NSString *item in monsterValueList){
            Monster *monster = [[Monster alloc] initWithAttribute:item];
            [monsterArray addObject:monster];
            [monster release];
        }
        _monsterArray = monsterArray;
        
        // init task list
        NSArray *taskValueList = [Utils readValueListByKey:@"tasks" src:sceneInfo];
        NSMutableArray *taskArray = [[NSMutableArray alloc] init];
        for(NSString *item in taskValueList){
            Task *task = [[Task alloc] initWithTaskId:item];
            [taskArray addObject:task];
            [task release];
        }
        _taskArray = taskArray;
    }
    
    return self;
}

- (Task *)getTaskByTalkToNPC:(NSString *)npc
{
    for(Task *item in _taskArray){
        if ([item canTriggerByTalkToNPC:npc]) {
            return item;
        }
    }
    return nil;
}

- (void)dealloc
{
    [_id release];
    [_title release];
    [_taskArray release];
    [_npcArray release];
    [_monsterArray release];
    [super dealloc];
}

@end
