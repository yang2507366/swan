//
//  Monster.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Monster.h"

@implementation Monster

- (id)initWithAttribute:(NSString *)attr
{
    self = [super initWithAttribute:attr];
    if (self) {
        // Initialization code here.
        _type = RoleTypeMonster;
    }
    
    return self;
}

@end
