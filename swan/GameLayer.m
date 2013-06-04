//
//  GameLayer.m
//  DD
//
//  Created by yangzexin on 11-8-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "AnimationUtils.h"

#import "RPGNPC.h"
#import "RPGMonster.h"
#import "RPGTaskStep.h"
#import "RPGTaskStepTalk.h"
#import "RPGTaskStepKillMonster.h"
#import "RPGTalk.h"

@implementation GameLayer

@synthesize currentTask = _currentTask;

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    GameLayer *layer = [GameLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"GameLayer");
        // init animations
        [AnimationUtils cacheAnimation:@"NpcWalkLeft"];
        [AnimationUtils cacheAnimation:@"HeroWalkUp"];
        [AnimationUtils cacheAnimation:@"HeroWalkDown"];
        [AnimationUtils cacheAnimation:@"HeroWalkLeft"];
        [AnimationUtils cacheAnimation:@"HeroWalkRight"];
        // init map
        [[CCTextureCache sharedTextureCache] addImage:@"map.png"];
        _map = [CCTMXTiledMap tiledMapWithTMXFile:@"untitled.tmx"];
        _collisionLayer = [[_map layerNamed:@"collision"] retain];
        _collisionLayer.visible = NO;
        // init hero
        _hero = [[CCSprite alloc] init];
        _hero.position = ccp(144, 144);
        _heroPosition = _hero.position;
        _heroDirection = RoleDirectionUp;
        CCAnimation *anim = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkUp"];
        anim.restoreOriginalFrame = YES;
        [_hero runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]]];
        [self addChild:_hero];
        [self addChild:_map z:-1];
        // init joystick
        
        // init rpg scene
        _myTaskArray = [[NSMutableArray alloc] init];
        _finishedTaskArray = [[NSMutableArray alloc] init];
        _scene = [[RPGScene alloc] initWithScriptName:@"scene1"];
        
        // add npc to scene
        NSArray *npcArray = _scene.npcArray;
        for(RPGNPC *npc in npcArray){
            [AnimationUtils cacheAnimation:npc.roldId];
            CCSprite *sprite = [[CCSprite alloc] init];
            sprite.position = ccp(npc.position.x * _map.tileSize.width, npc.position.y * _map.tileSize.height);
            [sprite setDisplayFrame:[[[[CCAnimationCache sharedAnimationCache] animationByName:npc.roldId] frames] objectAtIndex:0]];
            
            CCLabelTTF *lbl = [[CCLabelTTF alloc] initWithString:npc.roldId 
                                                      dimensions:CGSizeMake(80, 20) 
                                                       hAlignment:UITextAlignmentCenter 
                                                        fontName:@"Arial" fontSize:12.0f];
            lbl.position = CGPointMake(sprite.position.x, sprite.position.y - 32);
            [_map addChild:lbl z:8];
            [lbl release];
            
            [_map addChild:sprite z:7];
            [sprite release];
        }
        
        // add monster to scene
        NSArray *monsterArray = _scene.monsterArray;
        for(RPGMonster *monster in monsterArray){
        }
        
        // init dialog
        CCTexture2D *texture = [[CCTexture2D alloc] initWithCGImage:[UIImage imageNamed:@"dialog_bg"].CGImage resolutionType:kCCResolutioniPhone];
        _dialog = [[DialogLayer alloc] initWithTexture:texture];
        _dialog.position = ccp(240, 50);
        [_dialog setHidden:YES];
        [self addChild:_dialog];
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
        self.isTouchEnabled = YES;
        [self schedule:@selector(nextFrame:) interval:1.0f / 30.0f];
    }
    return self;
}

- (void)heroRunX:(NSInteger)vx Y:(NSInteger)vy
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if (_heroDirection == RoleDirectionLeft) {
        if (_map.position.x == 0 || _hero.position.x > winSize.width / 2) {
            CGFloat newX = _hero.position.x + vx;
            if (newX < 0) {
                newX = 0;
            }
            _hero.position = CGPointMake(newX, _hero.position.y);
            return;
        }
    }else if(_heroDirection == RoleDirectionRight){
        CGFloat newX = _hero.position.x + vx;
        if(_hero.position.x < winSize.width / 2){
            _hero.position = CGPointMake(newX, _hero.position.y);
            return;
        }
    }else if(_heroDirection == RoleDirectionDown){
        if (_map.position.y == 0 || _hero.position.y > winSize.height / 2) {
            CGFloat newY = _hero.position.y + vy;
            if (newY < 0) {
                newY = 0;
            }
            _hero.position = CGPointMake(_hero.position.x, newY);
            return;
        }
    }else if(_heroDirection == RoleDirectionUp){
        if (_hero.position.y < winSize.height / 2) {
            CGFloat newY = _hero.position.y + vy;
            if (newY > _map.tileSize.height * _map.mapSize.height) {
                newY = _map.tileSize.height * _map.mapSize.height;
            }
            _hero.position = CGPointMake(_hero.position.x, newY);
            return;
        }
    }
    
    CGFloat newX = _heroPosition.x + vx;
    CGFloat newY = _heroPosition.y + vy;
    newX = MAX(newX, winSize.width / 2);
    newX = MIN(_map.tileSize.width * _map.mapSize.width - winSize.width / 2, newX);
    newY = MAX(newY, winSize.height / 2);
    newY = MIN(_map.tileSize.height * _map.mapSize.height- winSize.height / 2, newY);
    _heroPosition = ccp(newX, newY);
    
    CGFloat targetX = _heroPosition.x;
    CGFloat targetY = _heroPosition.y;
    
    CGFloat actualX = MAX(targetX, winSize.width / 2);
    CGFloat actualY = MAX(targetY, winSize.height / 2);
    
    actualX = MIN(_map.tileSize.width * _map.mapSize.width - winSize.width / 2, actualX);
    actualY = MIN(_map.tileSize.height * _map.mapSize.height - winSize.height / 2, actualY);
    
    CGPoint lastPosition = _map.position;
    _map.position = ccpSub(ccp(winSize.width / 2, winSize.height / 2), ccp(actualX, actualY));
    if (lastPosition.x == _map.position.x) {
        if (_heroDirection == RoleDirectionRight) {
            CGFloat newX = _hero.position.x + vx;
            if (newX > winSize.width) {
                newX = winSize.width;
            }
            _hero.position = CGPointMake(newX, _hero.position.y);
        }
    }
    if (lastPosition.y == _map.position.y) {
        if (_heroDirection == RoleDirectionUp) {
            CGFloat newY = _hero.position.y + vy;
            if (newY > winSize.height) {
                newY = winSize.height;
            }
            _hero.position = CGPointMake(_hero.position.x, newY);
        }
    }
}

- (void)heroFrame
{
    CCAnimation *animation = nil;
    NSInteger vx = 0;
    NSInteger vy = 0;
    if (_heroDirection == RoleDirectionLeft) {
        animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkLeft"];
        vx = -SPEED;
    }else if(_heroDirection == RoleDirectionRight){
        animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkRight"];
        vx = SPEED;
    }else if(_heroDirection == RoleDirectionUp){
        animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkUp"];
        vy = SPEED;
    }else if(_heroDirection == RoleDirectionDown){
        animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkDown"];
        vy = -SPEED;
    }
    if (!_stickOn) {
        [_hero setDisplayFrame:[animation.frames objectAtIndex:0]];
        [_hero stopAllActions];
    }
    if (_heroStateChanged) {
        if (_stickOn) {
            animation.restoreOriginalFrame = YES;
            [_hero runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]]];
            
        }
    }else{
        if (_stickOn) {
            CGPoint lastHeroPosition = _hero.position;
            CGPoint lastMapPosition = _map.position;
            [self heroRunX:vx Y:vy];
            CGFloat heroX = _hero.position.x - _map.position.x;
            CGFloat heroY = _hero.position.y - _map.position.y;
            int x = heroX / _map.tileSize.width;
            int y = _map.mapSize.height - heroY / _map.tileSize.height;
            CGPoint point = CGPointMake(x, y);
            NSInteger tileGid = [_collisionLayer tileGIDAt:point];
            //NSLog(@"tileGid:%d", tileGid);
            if (tileGid != 0) {
                _map.position = lastMapPosition;
                _hero.position = lastHeroPosition;
            }
        }
    }
}

- (RPGNPC *)getNpcByPositionX:(NSInteger)x Y:(NSInteger)y
{
    NSArray *npcArray = _scene.npcArray;
    for(RPGNPC *npc in npcArray){
        NSInteger xdis = abs(npc.position.x - x);
        NSInteger ydis = abs(npc.position.y - y);
        if (xdis <= 1 && ydis <= 1) {
            return npc;
        }
    }
    return nil;
}

- (RPGTalk *)nextTalk
{
    if ([_talkArray count] != 0) {
        RPGTalk *talk = [_talkArray objectAtIndex:_talkIndex];
        return talk;
    }
    return nil;
}

- (void)alertTalk:(RPGTalk *)talk
{
    _talking = YES;
    [_dialog setTalkContent:talk.content];
    [_dialog setSelectorHidden:talk.type != TalkTypeAskTask];
    [_dialog setHidden:NO];
}

- (void)setCurrentStepDone
{
    [[_currentTask currentStep] setIsDone:YES];
    NSLog(@"new step gotted:%@", [_currentTask currentStep]);
    if ([_currentTask currentStep] == nil) {
        NSLog(@"current Task is over, give me the reward");
        NSLog(@"remove before:%d", [_myTaskArray count]);
        [_myTaskArray removeObject:_currentTask];
        [_finishedTaskArray addObject:_currentTask];
        NSLog(@"removed:%d", [_myTaskArray count]);
    }
}

- (void)handleStep:(RPGTaskStep *)step
{
    if (step.type == TaskStepTypeTalk) {
        NSLog(@"stepTalk:%@", step.targetId);
        RPGTaskStepTalk *stepTalk = (RPGTaskStepTalk *)step;
        _talkIndex = 0;
        if (_talkArray != nil) {
            [_talkArray release];
        }
        _talkArray = [stepTalk.dialogArray retain];
        RPGTalk *talk = [self nextTalk];
        [self alertTalk:talk];
    }else if(step.type == TaskStepTypeKillMonster){
        RPGTaskStepKillMonster *stepKillMonster = (RPGTaskStepKillMonster *)step;
        stepKillMonster.killedCount += 1;
        NSLog(@"monster kill +1");
        if (stepKillMonster.killedCount == stepKillMonster.needAmount) {
            [self setCurrentStepDone];
        }
    }
}

- (void)handleTalkWithNpc:(RPGNPC *)npc
{
    NSLog(@"talk to:%@", npc.roldId);
    
    NSString *npcId = npc.roldId;
    // 检查任务列表中是否有任务步骤与该npc有交集
    for(RPGTask *taskItem in _myTaskArray){
        RPGTaskStep *step = [taskItem currentStep];
        NSLog(@"npcId:%@, targetId:%@", npcId, step.targetId);
        if (step.type == TaskStepTypeTalk && [step.targetId isEqualToString:npcId]) {
            self.currentTask = taskItem;
            [self handleStep:step];
            return;
        }
    }
    
    // 检查是否可以获取任务
    RPGTask *task = [_scene getTaskByTalkToNPC:npcId];
    if (task != nil) {
        if (![_myTaskArray containsObject:task] && ![_finishedTaskArray containsObject:task]) {
            NSLog(@"new task");
            self.currentTask = task;
            RPGTaskStep *step = [task currentStep];
            [self handleStep:step];
            return;
        }
    }
}

- (void)handleButton
{
    
}

- (void)nextSentense
{
    if (!_dialog.selectorHidden) {
        return;
    }
    ++_talkIndex;
    if (_talkIndex != [_talkArray count]) {
        RPGTalk *talk = [self nextTalk];
        NSString *content = nil;
        if ([talk.fromId isEqualToString:@"HERO"]) {
            content = [NSString stringWithFormat:@"我：%@", talk.content];
        }else{
            content = [NSString stringWithFormat:@"%@：%@", talk.fromId, talk.content];
        }
        [_dialog setTalkContent:talk.content];
        [_dialog setSelectorHidden:talk.type != TalkTypeAskTask];
        [_dialog setHidden:NO];
    }else{
        [_dialog setHidden:YES];
        NSLog(@"talk over");
        [self setCurrentStepDone];
    }
}

- (void)handleDialog
{
    if ([NSDate timeIntervalSinceReferenceDate] - _lastDialogTime < 0.2) {
        return;
    }
    if (_dialog.yesClicked) {
        // accept current task
        //NSLog(@"accept task:%@", _currentTask);
        [_myTaskArray addObject:_currentTask];
        [_dialog setSelectorHidden:YES];
        [self nextSentense];
        _lastDialogTime = [NSDate timeIntervalSinceReferenceDate];
    }else if (_dialog.noClicked) {
        // cancel current task
        [_currentTask resetAllStep];
        self.currentTask = nil;
        _talkIndex = 0;
        [_dialog setHidden:YES];
    }else if (_dialog.contentClicked) {
        [self nextSentense];
        _lastDialogTime = [NSDate timeIntervalSinceReferenceDate];
    }
}

- (void)handleTouch
{
    if (_touched) {
        CGFloat realX = _touchPoint.x - _map.position.x;
        CGFloat readY = _touchPoint.y - _map.position.y;
        
        int x = realX / _map.tileSize.width;
        int y = readY / _map.tileSize.height;
        
        RPGNPC *npc = [self getNpcByPositionX:x Y:y];
        if(npc != nil){
            if (!_handlingTalk) {
                [self handleTalkWithNpc:npc];
                _handlingTalk = YES;
            }
        }
    }
}

- (void)nextFrame:(ccTime)delta
{
    BOOL lastOn = _stickOn;
    RoleDirection direction = _heroDirection;
    _heroStateChanged = lastOn != _stickOn;
    if (!_heroStateChanged) {
        _heroStateChanged = direction != _heroDirection;
    }
    
    [self heroFrame];
    [self handleButton];
    [self handleDialog];
    [self handleTouch];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    _touched = YES;
    _touchPoint = [self convertTouchToNodeSpace:touch];
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _touched = NO;
    _handlingTalk = NO;
}


- (void)dealloc
{
    [_dialog release];
    [_map release];
    [_hero release];
    [_collisionLayer release];
    [super dealloc];
}

@end
