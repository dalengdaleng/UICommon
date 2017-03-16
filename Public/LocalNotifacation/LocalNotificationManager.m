//
//  LocalNotificationManager.m
//  JusAuto
//
//  Created by ju on 2017/2/17.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "LocalNotificationManager.h"
#import "CWStatusBarNotification.h"

@implementation LocalNotificationManager
+ (instancetype)sharedInstance
{
    static LocalNotificationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance)
            {
                instance = [[LocalNotificationManager alloc] init];
            }
    });
    return instance;
}

- (void)localNotificationUser:(NSString *)aInfo localKey:(NSString *)aKey
{
    NSString *suffix = @"";
    if (IS_IPHONE6PLUS) {
        suffix = @"-736h";
    } else if (IS_IPHONE6) {
        suffix = @"-667h";
    } else if (IS_IPHONE5) {
        suffix = @"-568h";
    }
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    
    if (noti) {
        //设置推送时间
        noti.fireDate = date;
        //设置时区
        noti.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        noti.repeatInterval = 0;
        //推送声音
        noti.soundName = UILocalNotificationDefaultSoundName;
        noti.applicationIconBadgeNumber = 0;
        
        NSString *imageName = [@"Default" stringByAppendingString:suffix];
        noti.alertLaunchImage = imageName;
        //内容
        noti.alertBody = aInfo;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"startDriveMode" forKey:aKey];
        noti.userInfo = infoDic;
        //添加推送到uiapplication
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    }
}


- (void)cancelLocalNotification:(NSString *)aKey
{
    UIApplication *app = [UIApplication sharedApplication];
    
    //获取本地推送数组
    
    NSArray *localArr = [app scheduledLocalNotifications];
    
    
    
    //声明本地通知对象
    
    UILocalNotification *localNoti;
    
    
    
    if (localArr) {
        
        for (UILocalNotification *noti in localArr) {
            
            NSDictionary *dict = noti.userInfo;
            
            if (dict) {
                
                NSString *inKey = [dict objectForKey:@"key"];
                
                if ([inKey isEqualToString:aKey]) {
                    
                    if (localNoti){
                        
                        localNoti = nil;
                        
                    }
                    
                    localNoti = [noti copy];
                    
                    break;
                    
                }
                
            }
            
        }
        
        
        
        //判断是否找到已经存在的相同key的推送
        
        if (!localNoti) {
            
            //不存在 初始化
            
            localNoti = [[UILocalNotification alloc] init];
            
        }
        
        
        
        if (localNoti) {
            
            //不推送 取消推送
            
            [app cancelLocalNotification:localNoti];

            localNoti = nil;
            return;
            
        }
        
    }
}
@end
