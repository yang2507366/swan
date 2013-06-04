//
//  Dialog.m
//  DD
//
//  Created by yangzexin on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DialogLayer.h"


@implementation DialogLayer

@synthesize yesClicked = _isYesClicked;
@synthesize noClicked = _isNoClicked;
@synthesize contentClicked = _isContentClicked;
@synthesize selectorHidden = _isSelectorHidden;

- (void)setHidden:(BOOL)hidden
{
    if (self.visible == !hidden) {
        return;
    }
    _isYesClicked = NO;
    _isNoClicked = NO;
    _isContentClicked = NO;
    [self setVisible:!hidden];
    if (!hidden) {
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }else{
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    }
}

- (id)initWithTexture:(CCTexture2D *)texture
{
    self = [super initWithTexture:texture];
    if (self) {
        _isYesClicked = NO;
        _isNoClicked = NO;
        _isContentClicked = NO;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        _approveBtn = [[CCLabelTTF labelWithString:@"接受" fontName:@"Arial" fontSize:12.0f] retain];
        _approveBtn.position = ccp(20, 12);
        _approveBtn.visible = YES;
        [self addChild:_approveBtn];
        
        _cancelBtn = [[CCLabelTTF labelWithString:@"取消" fontName:@"Arial" fontSize:12.0f] retain];
        _cancelBtn.position = ccp(winSize.width - 30, 12);
        _cancelBtn.visible = YES;
        [self addChild:_cancelBtn];
        
        _talkContent = [[CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:12.0f] retain];
        _talkContent.position = ccp(_talkContent.textureRect.size.width / 2 + 10, 80);
        [self addChild:_talkContent];
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
    return self;
}

- (void)setSelectorHidden:(BOOL)hidden
{
    _approveBtn.visible = !hidden;
    _cancelBtn.visible = !hidden;
    _isSelectorHidden = hidden;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    if ( _approveBtn.visible && point.x < 60 && point.y < 40) {
        _isYesClicked = YES;
    }else if (_cancelBtn.visible && point.x > 430 && point.y < 40) {
        _isNoClicked = YES;
    }else{
        _isContentClicked = YES;
    }
    
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _isYesClicked = NO;
    _isNoClicked = NO;
    _isContentClicked = NO;
}

- (void)setTalkContent:(NSString *)str
{
    [_talkContent setString:str];
    _talkContent.position = ccp(_talkContent.textureRect.size.width / 2 + 10, 80);
}
- (void)dealloc
{
    [_approveBtn release];
    [_cancelBtn release];
    [super dealloc];
}
@end
