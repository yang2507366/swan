//
//  Talk.h
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TalkTypeNormal,
    TalkTypeAskTask
}TalkType;

@interface Talk : NSObject {
    NSString *_fromId;
    NSString *_content;
    TalkType _type;
}

@property(nonatomic, readonly)NSString *fromId;
@property(nonatomic, readonly)NSString *content;
@property(nonatomic, readonly)TalkType type;

- (id)initWithAttribute:(NSString *)attr;

@end
