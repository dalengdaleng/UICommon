//
//  LocalNotificationManager.h
//  JusAuto
//
//  Created by ju on 2017/2/17.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDriveKey @"driveStartMode"

@interface LocalNotificationManager : NSObject
+ (instancetype)sharedInstance;
- (void)localNotificationUser:(NSString *)aInfo localKey:(NSString *)aKey;
- (void)cancelLocalNotification:(NSString *)aKey;
@end
