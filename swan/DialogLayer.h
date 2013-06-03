//
//  Dialog.h
//  DD
//
//  Created by yangzexin on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DialogLayer : CCSprite <CCTargetedTouchDelegate> {
    BOOL _isYesClicked;
    BOOL _isNoClicked;
    BOOL _isContentClicked;
    BOOL _isSelectorHidden;
    CCLabelTTF *_approveBtn;
    CCLabelTTF *_cancelBtn;
    CCLabelTTF *_talkContent;
}

@property(nonatomic, readonly)BOOL yesClicked;
@property(nonatomic, readonly)BOOL noClicked;
@property(nonatomic, readonly)BOOL contentClicked;
@property(nonatomic, readonly)BOOL selectorHidden;
- (void)setSelectorHidden:(BOOL)hidden;
- (void)setTalkContent:(NSString *)str;
- (void)setHidden:(BOOL)hidden;

@end
