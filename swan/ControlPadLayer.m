//
//  ControlPadLayer.m
//  swan
//
//  Created by yangzexin on 6/5/13.
//
//

#import "ControlPadLayer.h"
#import "ControlButton.h"

@interface ControlPadLayer ()

@end

@implementation ControlPadLayer

- (void)onEnter
{
    [super onEnter];
    
    ControlButton *moveButton = [[[ControlButton alloc] initWithFrame:CGRectMake(40, 20, 80, 80)] autorelease];
    [self addChild:moveButton];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    ControlButton *action1Button = [[[ControlButton alloc] initWithFrame:CGRectMake(winSize.width - 70, 70, 30, 30)] autorelease];
    [self addChild:action1Button];
    
    ControlButton *action2Button = [[[ControlButton alloc] initWithFrame:CGRectMake(winSize.width - 120, 30, 30, 30)] autorelease];
    [self addChild:action2Button];
}

@end
