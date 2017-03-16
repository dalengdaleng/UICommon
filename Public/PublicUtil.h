//
//  PublicUtil.h
//  JusAuto
//
//  Created by ju on 2017/2/8.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface PublicUtil : NSObject
    
//语言设置接口
+ (void)LanguageSetUserLanguage:(NSString *)aLanguage;
+ (NSString *)LanguageGetUserLanguage;
+ (NSBundle *)LanguageGetBundle;

//导航栏的接口

//屏幕尺寸kpi
+ (CGFloat)screenKpi;

//文件路径
+ (NSString *)FileManagerLogDirectory;

//开启驾驶模式保存
+ (void)DriveModeFlag:(BOOL)aFlag;
+ (BOOL)DriveModeGetFlag;

//用户首次点击启动驾驶模式保存
+ (void)SetUserFirstTapStartDrive:(BOOL)aFlag;
+ (BOOL)GetUserFirstTapStartDrive;

//判断是否安装了JusTalk
+ (BOOL)isInstallJusTalk;

//打开justalk
+ (void)openJustalk;

+ (NetworkStatus)getNetStatus;

//网络不好用的提示
+ (void)showNotNetTip;

//记录本地通知
+ (BOOL)isLocalNotification;
+ (void)SetLocalNotification:(BOOL)aSet;
@end
