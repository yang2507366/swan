//
//  Talk.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RPGTalk.h"
#import "Utils.h"

@implementation RPGTalk

@synthesize fromId = _fromId;
@synthesize content = _content;
@synthesize type = _type;

- (id)initWithAttribute:(NSString *)attr
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSString *from = [Utils readAttributeByKey:@"FROM" src:attr];
        if (![from isEqualToString:@"HERO"]) {
            _fromId = [from retain];
        }
        _content = [[Utils readAttributeByKey:@"CONTENT" src:attr] retain];
        
        NSString *type = [Utils readAttributeByKey:@"TYPE" src:attr];
        if ([type isEqualToString:@"NORMAL"]) {
            _type = TalkTypeNormal;
        }else if([type isEqualToString:@"ASK_TASK"]){
            _type = TalkTypeAskTask;
        }
    }
    
    return self;
}

- (void)dealloc
{
    [_fromId release];
    [_content release];
    [super dealloc];
}

@end
