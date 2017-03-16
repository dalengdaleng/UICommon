//
//  AutoPlayerManager.h
//  JusAuto
//
//  Created by ju on 2017/3/1.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallKitManager.h"

@protocol AutoPlayerManagerProtocol <NSObject>

- (void)autoAnswerCall:(CallKitCall *)aCall;

@end

@interface AutoPlayerManager : NSObject
@property (nonatomic, weak) id<AutoPlayerManagerProtocol>delegate;
@property (nonatomic, assign) BOOL isCallkitRing;

+ (instancetype)sharedInstance;

- (void)startRingTimer:(CallKitCall *)aCall;
- (void)stopRingTimer;

- (void)startSpeaker;

- (CallKitCall *)getCurrentCallKit;
@end
