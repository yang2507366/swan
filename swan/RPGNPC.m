//
//  NPC.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RPGNPC.h"

@implementation RPGNPC

- (id)initWithAttribute:(NSString *)attr
{
    self = [super initWithAttribute:attr];
    if (self) {
        _type = RoleTypeNPC;
    }
    return self;
}

@end
