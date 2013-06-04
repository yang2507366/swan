//
//  Monster.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RPGMonster.h"

@implementation RPGMonster

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
