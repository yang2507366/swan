//
//  GameLayer.h
//  DD
//
//  Created by yangzexin on 11-8-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DialogLayer.h"

#import "RPGScene.h"
#import "RPGTask.h"

#define SPEED 7

typedef enum{
    RoleDirectionLeft,
    RoleDirectionRight,
    RoleDirectionUp,
    RoleDirectionDown
}RoleDirection;

@interface GameLayer : CCLayer <CCTargetedTouchDelegate> {
    CCSprite *_hero;
    CCTMXTiledMap *_map;
    CCTMXLayer *_collisionLayer;
    RoleDirection _heroDirection;
    BOOL _stickOn;
    BOOL _heroStateChanged;
    CGPoint _heroPosition;
    
    BOOL _touched;
    CGPoint _touchPoint;
    
    BOOL _handlingTalk;
    BOOL _talking;
    
    NSTimeInterval _lastDialogTime;
    
    DialogLayer *_dialog;
    
    RPGScene *_scene;
    NSMutableArray *_myTaskArray;
    NSMutableArray *_finishedTaskArray;
    NSArray *_talkArray;
    NSInteger _talkIndex;
    RPGTask *_currentTask;
    
    NSMutableArray *_npcArray;
}

@property(nonatomic, retain)RPGTask *currentTask;

+ (CCScene *)scene;

@end
