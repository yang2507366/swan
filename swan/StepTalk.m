//
//  StepTalk.m
//  RPGSimulator
//
//  Created by yangzexin on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StepTalk.h"
#import "Utils.h"
#import "Talk.h"

@implementation StepTalk

@synthesize dialogArray = _dialogArray;

- (id)initTaskStepWithAttribute:(NSString *)attr
{
    self = [super initTaskStepWithAttribute:attr];
    if (self) {
        // Initialization code here.
        _dialogId = [[Utils readAttributeByKey:@"DIALOG" src:attr] retain];
        
        // read talk array
        NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:_dialogId];
        NSString *talkStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSArray *talkStrArray = [talkStr componentsSeparatedByString:@"##"];
        NSMutableArray *dialogArray = [[NSMutableArray alloc] init];
        for(NSString *item in talkStrArray){
            if (![[item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
                Talk *talk = [[Talk alloc] initWithAttribute:item];
                [dialogArray addObject:talk];
                [talk release];
            }
        }
        _dialogArray = dialogArray;
    }
    
    return self;
}

- (void)dealloc
{
    [_dialogId release];
    [_dialogArray release];
    [super dealloc];
}

@end
