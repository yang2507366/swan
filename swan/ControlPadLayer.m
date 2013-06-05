//
//  ControlPadLayer.m
//  swan
//
//  Created by yangzexin on 6/5/13.
//
//

#import "ControlPadLayer.h"

@interface ControlPadLayer ()

@end

@implementation ControlPadLayer

- (void)onEnter
{
    [super onEnter];
    self.isTouchEnabled = YES;
}

- (void)drawCircleWithPosition:(CGPoint)position size:(CGSize)size
{
    ccDrawCircle(CGPointMake(position.x + (size.width / 2), position.y + (size.height / 2)), size.width / 2, M_PI * 2, 50, NO);
}

- (void)draw
{
    CGPoint leftControlPosition = CGPointMake(40, 20);
    CGSize leftControlSize = CGSizeMake(80, 80);
    [self drawCircleWithPosition:leftControlPosition size:leftControlSize];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGSize actionButtonSize = CGSizeMake(30, 30);
    CGPoint rightActionPosition = CGPointMake(winSize.width - actionButtonSize.width - 40, 70);
    [self drawCircleWithPosition:rightActionPosition size:actionButtonSize];
    CGPoint leftActionButtonPosition = CGPointMake(rightActionPosition.x - actionButtonSize.width - 30, 40);
    [self drawCircleWithPosition:leftActionButtonPosition size:actionButtonSize];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return NO;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", touches);
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", touches);
}

@end
