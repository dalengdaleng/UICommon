//
//  Settings.h
//  Batter
//
//  Created by cathy on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeModel.h"
extern NSString * const SettingsSkinColorWillChangeNotification;
extern NSString * const SettingsSkinColorChangedNotification;
extern NSString * const SettingsSkinColorCancelNotification;
extern NSString * const SettingsNotificationColorKey;

@interface Settings : NSObject

+ (NSArray<__kindof ThemeModel *>*)FestivalThemeArray;
+ (NSArray<__kindof ThemeModel *>*)ColorThemeArray;
+ (NSArray<__kindof ThemeModel *>*)ColorThemeArrayForSimplelyDisPlay;
+ (NSArray<__kindof ThemeModel *>*)newThemes;
+ (void)applyTheme:(ThemeModel *)theme;
+ (void)setSkinColor:(UIColor *)skinColor;

+ (UIColor *)highlightedColor:(UIColor *)color;
+ (UIColor *)disabledColor:(UIColor *)color;

+ (UIColor *)skinColor;
+ (UIColor *)highlightedSkinColor;
+ (UIColor *)disabledSkinColor;

+ (UIColor *)primaryTextColor;
+ (UIColor *)secondaryTextColor;
+ (UIColor *)disabledTextColor;
+ (UIColor *)whiteDisabledTextColor;
+ (UIColor *)dividersColor;

+ (UIColor *)groupTableViewBgColor;

+ (UIColor *)keypadDeleteHighlightedColor;

+ (UIColor *)callEndColor;
+ (UIColor *)callAnswerColor;

+ (UIColor *)loadingViewBgColor;
+ (UIColor *)sectionHeaderBgColor;

+ (UIColor *)badgeViewBgColor;

+ (UIFont *)primaryTextFont;
+ (UIFont *)contactsTextFont;

+ (UIColor *)color:(UIColor *)color withHueValue:(CGFloat)value;
+ (CGFloat)hueValueOfColor:(UIColor *)color;
+ (UIColor *)color:(UIColor *)color withBrightnessValue:(CGFloat)value;
+ (CGFloat)brightnessValueOfColor:(UIColor *)color;

+ (UIColor *)facebookColor;

+ (UIColor *)randomCallButtonColor;
+ (UIColor *)featureRandomCallColor;

+ (UIColor *)cameraOffBackgroundDarkColor;
+ (UIColor *)cameraOffBackgroundLightColor;

+ (UIColor *)jusPointsColor;
+ (UIColor *)jusPointsTodayColor;
+ (UIColor *)jusPointsFutureColor;
+ (UIColor *)jusPointsBorderColor;

+ (NSArray *)doodleColorArray;

+ (void)setThemeImage:(UIImage *)themeImage;
+ (UIImage *)themeImage;
+ (UIImage *)themeImageAbout;
+ (UIImage *)launchImage;

+ (UIColor *)AdsNextButtonBackgroundColor;

+ (UIColor *)JusCommonColor;

@end
