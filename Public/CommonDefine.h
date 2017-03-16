//
//  CommonDefine.h
//  JusAuto
//
//  Created by ju on 2017/2/8.
//  Copyright © 2017年 ju. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height >= 667)
#define IS_IPHONE6PLUS ([[UIScreen mainScreen] bounds].size.height > 667)

#define ThemeVersion 4

/**
 *  获取mainScreen的bounds
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kScreenApi kScreenWidth/320.f

#define kDesignCommonWidth kScreenWidth

/**
 *  获取Window
 */
#define kWindow [UIApplication sharedApplication].keyWindow

//获取appdelegate
#define kAppDelegate [[UIApplication sharedApplication] delegate]

//获取delegate window
#define kAppDelegateWindow [[[UIApplication sharedApplication] delegate] window]

/**
 *  版本号
 *
 *  @param  CFBundleShortVersionString
 *
 *  @return kVersion
 */
#define kVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]

/**
 *  懒人简化书写宏
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/**
 *  iPhone or iPad
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


/**
 *  NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//File Path
#define PATH_OF_DOCUMENT_FOLDER    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_Cache_FOLDER    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif /* CommonDefine_h */
