//
//  ControlButton.m
//  swan
//
//  Created by yangzexin on 6/5/13.
//
//

#import "ControlButton.h"

@interface ControlButton ()

@property(nonatomic, assign)CGRect frame;

@end

@implementation ControlButton

- (void)dealloc
{
    self.image = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    
    self.frame = frame;
    self.isTouchEnabled = YES;
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    if(_image != image){
        [_image release];
        _image = [image retain];
    }
}

static void drawCircle(CGPoint position, CGSize size)
{
    ccDrawCircle(CGPointMake(position.x + (size.width / 2), position.y + (size.height / 2)), size.width / 2, M_PI * 2, 50, NO);
}

- (void)draw
{
    drawCircle(self.frame.origin, self.frame.size);
}

@end
