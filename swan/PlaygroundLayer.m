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

@interface PlaygroundLayer ()

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
    
    [self scheduleUpdate];
    
    return self;
}

- (void)onEnter
{
    NSArray *frames = [AnimationUtils cacheAnimation:@"HeroWalkRight"];
    CCSprite *sprite = [[[CCSprite alloc] initWithSpriteFrame:[frames objectAtIndex:0]] autorelease];
    sprite.position = ccp(144, 144);
    [self addChild:sprite];
    [sprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[AnimationUtils animationByName:@"HeroWalkRight"]]]];
}

@end
