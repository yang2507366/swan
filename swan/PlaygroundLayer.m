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
    // init map
    [[CCTextureCache sharedTextureCache] addImage:@"map.png"];
    self.map = [CCTMXTiledMap tiledMapWithTMXFile:@"untitled.tmx"];
    [self addChild:self.map z:-1];
    self.collisionLayer = [self.map layerNamed:@"collision"];
    self.collisionLayer.visible = NO;
    // init hero
    self.hero = [[[CCSprite alloc] init] autorelease];
    self.hero.position = ccp(144, 200);
    self.heroPosition = self.hero.position;
    self.heroDirection = RoleDirectionUp;
    CCAnimation *tmpAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:@"HeroWalkUp"];
    tmpAnimation.restoreOriginalFrame = YES;
    [self.hero runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:tmpAnimation]]];
    [self addChild:self.hero];
}

@end
