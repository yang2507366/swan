//
//  PigScene.m
//  swan
//
//  Created by yangzexin on 6/5/13.
//
//

#import "PigScene.h"
#import "ControlPadLayer.h"

@implementation PigScene

- (void)onEnter
{
    [super onEnter];
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"TEST" fontName:@"Arial" fontSize:16.0f];
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//    label.position = ccp(winSize.width / 2, winSize.height / 2);
//    [self addChild:label];
    ControlPadLayer *controlPad = [[ControlPadLayer new] autorelease];
    [self addChild:controlPad];
}

@end
