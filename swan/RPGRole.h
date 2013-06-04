//
//  Role.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    RoleTypeNPC,
    RoleTypeMonster
}RoleType;

@interface RPGRole : NSObject {
    NSString *_id;
    CGPoint _position;
    RoleType _type;
}

@property(nonatomic, readonly)CGPoint position;
@property(nonatomic, readonly)NSString *roldId;
@property(nonatomic, readonly)RoleType type;

- (id)initWithAttribute:(NSString *)attr;

@end
