//
//  BlueToothManager.h
//  JusAuto
//
//  Created by ju on 2017/2/27.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BlueToothProtocol <NSObject>

- (void)blueToothConnected:(BOOL)aResult;
- (void)blueToothDisConnected:(BOOL)aResult;
@end  

@interface BlueToothManager : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<BlueToothProtocol>delegate;

- (BOOL)blueToothOpened;
@end
