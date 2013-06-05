//
//  PlaygroundLayer.m
//  swan
//
//  Created by yangzexin on 13-6-4.
//
//

#import "PlaygroundLayer.h"
#import "AnimationUtils.h"
#import "RPGScene.h"

typedef enum{
    RoleDirectionLeft,
    RoleDirectionRight,
    RoleDirectionUp,
    RoleDirectionDown
}RoleDirection;

@interface PlaygroundLayer ()

@property(nonatomic, retain)CCTMXTiledMap *map;
@property(nonatomic, retain)CCTMXLayer *collisionLayer;
@property(nonatomic, retain)CCSprite *hero;
@property(nonatomic, assign)CGPoint heroPosition;
@property(nonatomic, assign)RoleDirection heroDirection;
@property(nonatomic, retain)NSMutableArray *myTaskArray;
@property(nonatomic, retain)NSMutableArray *finishedTaskArray;
@property(nonatomic, retain)RPGScene *scene;

@end

@implementation PlaygroundLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    [scene addChild:[PlaygroundLayer node]];
    
    return scene;
}

- (id)init
{
    self = [super init];
    
    [AnimationUtils cacheAnimation:@"HeroWalkUp"];
    [AnimationUtils cacheAnimation:@"HeroWalkDown"];
    [AnimationUtils cacheAnimation:@"HeroWalkLeft"];
    [AnimationUtils cacheAnimation:@"HeroWalkRight"];
    
    return self;
}

- (void)onEnter
{
    [super onEnter];
    // init map
    [[CCTextureCache sharedTextureCache] addImage:@"map.png"];
    self.map = [CCTMXTiledMap tiledMapWithTMXFile:@"untitled.tmx"];
    [self addChild:self.map z:-1];
    self.collisionLayer = [self.map layerNamed:@"collision"];
    self.collisionLayer.visible = NO;
    // init hero
    self.hero = [[[CCSprite alloc] init] autorelease];
    self.hero.position = ccp(144, 144);
    self.heroPosition = self.hero.position;
    self.heroDirection = RoleDirectionUp;
    CCAnimation *tmpAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkRight"];
    tmpAnimation.restoreOriginalFrame = YES;
    [self.hero runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:tmpAnimation]]];
    [self addChild:self.hero];
    
    // init rpg scene
    self.myTaskArray = [NSMutableArray array];
    self.finishedTaskArray = [NSMutableArray array];
    self.scene = [[[RPGScene alloc] initWithScriptName:@"scene1"] autorelease];
    
    // add npc to scene
    NSArray *npcArray = self.scene.npcArray;
    for(RPGNPC *npc in npcArray){
        [AnimationUtils cacheAnimation:npc.roldId];
        CCSprite *sprite = [[[CCSprite alloc] init] autorelease];
        sprite.position = ccp(npc.position.x * (self.map.tileSize.width) / 2, npc.position.y * (self.map.tileSize.height) / 2);
        NSArray *frames = [[[CCAnimationCache sharedAnimationCache] animationByName:npc.roldId] frames];
        if(frames.count != 0){
            CCAnimationFrame *animFrame = [frames objectAtIndex:0];
            [sprite setDisplayFrame:animFrame.spriteFrame];
        }
        
        CCLabelTTF *lbl = [[[CCLabelTTF alloc] initWithString:npc.roldId
                                                   dimensions:CGSizeMake(80, 20)
                                                   hAlignment:UITextAlignmentCenter
                                                     fontName:@"Arial" fontSize:12.0f] autorelease];
        lbl.position = CGPointMake(sprite.position.x, sprite.position.y - 16);
        [self.map addChild:lbl z:7];
        [self.map addChild:sprite z:8];
    }
    
    [self schedule:@selector(update:) interval:1.0f/24.0f];
    [self.hero runAction:[CCMoveTo actionWithDuration:5.0f position:ccp(480, 144.0f)]];
}

- (void)update:(ccTime)interval
{
    if(self.hero.position.x == 480.0f){
        [self.hero stopAllActions];
        [self.hero runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[AnimationUtils animationByName:@"HeroWalkLeft"]]]];
        [self.hero runAction:[CCMoveTo actionWithDuration:1.0f position:ccp(0, 144.0f)]];
    }else if(self.hero.position.x == 0){
        [self.hero stopAllActions];
        [self.hero runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[AnimationUtils animationByName:@"HeroWalkRight"]]]];
        [self.hero runAction:[CCMoveTo actionWithDuration:1.0f position:ccp(480.0f, 144.0f)]];
    }
}

@end
