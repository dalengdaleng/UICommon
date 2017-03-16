//
//  PublicUtil.m
//  JusAuto
//
//  Created by ju on 2017/2/8.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "PublicUtil.h"

//语言定义
#define kUserLanguageKey  @"UserLanguage"

#define kDriveModeKey @"kDriveModeKey"

#define kUserFirstTapStartMode @"kUserFirstTapStartMode"
#define kLocalNotification @"kLocalNotification"

@implementation PublicUtil
+ (void)LanguageSetUserLanguage:(NSString *)aLanguage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:aLanguage forKey:kUserLanguageKey];
    [userDefaults synchronize];
}
    
+ (NSString *)LanguageGetUserLanguage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [userDefaults stringForKey:kUserLanguageKey];
    return language;
}

+ (NSBundle *)LanguageGetBundle
{
    NSString *userLanguage = [self LanguageGetUserLanguage];
    if (userLanguage.length == 0)
    {
        return [NSBundle mainBundle];
    }
    else
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
        NSBundle *bundle = [NSBundle bundleWithPath:path];
        return bundle;
    }
}

+ (NSString *)FileManagerLogDirectory
{
#ifdef APP_STORE
    return [PATH_OF_Cache_FOLDER stringByAppendingString:@"/log"];
#else
    return [PATH_OF_DOCUMENT_FOLDER stringByAppendingString:@"/log"];
#endif
}

+ (CGFloat)screenKpi
{
    return kScreenWidth / 320.f;
}

+ (void)DriveModeFlag:(BOOL)aFlag
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:aFlag] forKey:kDriveModeKey];
    [userDefaults synchronize];
}

+ (BOOL)DriveModeGetFlag
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL modeFlag = [userDefaults boolForKey:kDriveModeKey];
    return modeFlag;
}

+ (void)SetUserFirstTapStartDrive:(BOOL)aFlag
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:aFlag] forKey:kUserFirstTapStartMode];
    [userDefaults synchronize];
}

+ (BOOL)GetUserFirstTapStartDrive
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL tapStart = [userDefaults boolForKey:kUserFirstTapStartMode];
    return tapStart;
}

+ (BOOL)isInstallJusTalk
{
    BOOL hasJusTalk = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"justalk://"]];
    return hasJusTalk;
}

+ (void)openJustalk
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"justalk://justalk"]];
}

+ (NetworkStatus)getNetStatus
{
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    return internetStatus;
}

+ (void)showNotNetTip
{
    NSString *failedText = kStringCheckNetworkAndRetry;
    if ([self getNetStatus] == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:failedText delegate:nil cancelButtonTitle:kStringOk otherButtonTitles:nil];
        [alert show];
        return;
    }
}

+ (BOOL)isLocalNotification
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL setFlag = [userDefaults boolForKey:kLocalNotification];
    return setFlag;
}

+ (void)SetLocalNotification:(BOOL)aSet
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:aSet] forKey:kLocalNotification];
    [userDefaults synchronize];
}
@end
