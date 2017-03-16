//
//  Settings.m
//  Batter
//
//  Created by cathy on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
NSString * const SettingsSkinColorWillChangeNotification = @"SettingsSkinColorWillChangeNotification";
NSString * const SettingsSkinColorChangedNotification = @"SettingsSkinColorChangedNotification";
NSString * const SettingsSkinColorCancelNotification = @"SettingsSkinColorCancelNotification";
NSString * const SettingsNotificationColorKey = @"SettingsNotificationColorKey";

static UIColor *_skinColor = nil;


static UIImage *_themeImage = nil;
static UIImage *_themeImageAbout = nil;

@implementation Settings

+(NSArray<__kindof ThemeModel *>*)FestivalThemeArray
{
    return @[
             [ThemeModel yearOfRooster],
             [ThemeModel valentineDay],
             [ThemeModel magpieFestival],
             [ThemeModel childrenDay],
             [ThemeModel montherDay],
             [ThemeModel yearOfMonkey],
             [ThemeModel fatherDay],
             ];

}

+(NSArray<__kindof ThemeModel *>*)ColorThemeArray
{
    return @[
             [ThemeModel pink],
             [ThemeModel purple],
             [ThemeModel indigo],
             [ThemeModel blue],
             //[ThemeModel cyan],
             [ThemeModel green],
             [ThemeModel amber],
             [ThemeModel orange],
             [ThemeModel deepOrange],
             ];
}

+(NSArray<__kindof ThemeModel *>*)ColorThemeArrayForSimplelyDisPlay
{
    return @[
             [ThemeModel classicBlue],
             ];
}

+(void)applyTheme:(ThemeModel *)theme
{
    [theme saveThemeToUserDefaults];
    [Settings setSkinColor:theme.color];
    [Settings setThemeImage:theme.image];
    [[NSNotificationCenter defaultCenter] postNotificationName:SettingsSkinColorChangedNotification
                                                        object:nil
                                                      userInfo:nil];
}

+(ThemeModel *)defaultTheme
{
    return [ThemeModel yearOfRooster];
}

+(NSArray<__kindof ThemeModel *>*)newThemes
{
    return @[
             [ThemeModel yearOfRooster],
             ];
}

+ (UIColor *)skinColor
{
    if (!_skinColor) {
#ifdef JUSTEE
        _skinColor = [UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:235.0f/255.0f alpha:1];
#else
        ThemeModel *theme = [ThemeModel presentTheme];
        if (!theme) {
            theme = [Settings defaultTheme];
            [theme saveThemeToUserDefaults];
        }
        _skinColor = theme.color;
        _themeImage = theme.image;
#endif
    }
    return _skinColor;
}

+(void)setSkinColor:(UIColor *)skinColor
{
    _skinColor = skinColor;
}

+ (UIImage *)themeImage
{
//    if (IS_IPAD) {
//        return nil;
//    }
    if (!_themeImage) {
        ThemeModel *theme = [ThemeModel presentTheme];
        if (!theme) {
            theme = [Settings defaultTheme];
            [theme saveThemeToUserDefaults];
        }
        _skinColor  = theme.color;
        _themeImage = theme.image;
    }
    return _themeImage;
}

+ (UIImage *)launchImage
{
    ThemeModel *theme = [ThemeModel presentTheme];
    if (!theme) {
        theme = [Settings defaultTheme];
        [theme saveThemeToUserDefaults];
    }
    return theme.launchImage;
}

+(void)setThemeImage:(UIImage *)themeImage
{
    _themeImage = themeImage;
}

+ (UIImage *)themeImageAbout
{
    return [ThemeModel presentTheme].aboutImage;
}

+ (UIColor *)highlightedColor:(UIColor *)color
{
    return [color colorWithAlphaComponent:0.26];
}

+ (UIColor *)disabledColor:(UIColor *)color
{
    return [color colorWithAlphaComponent:0.54];
}

+ (UIColor *)highlightedSkinColor
{
    return [Settings highlightedColor:[Settings skinColor]];
}

+ (UIColor *)disabledSkinColor
{
    return [Settings disabledColor:[Settings skinColor]];
}

+ (UIColor *)primaryTextColor
{
    static UIColor *_primaryTextColor = nil;
    if (!_primaryTextColor) {
        _primaryTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.87];
    }
    return _primaryTextColor;
}

+ (UIColor *)secondaryTextColor
{
    static UIColor *_secondaryTextColor = nil;
    if (!_secondaryTextColor) {
        _secondaryTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.54];
    }
    return _secondaryTextColor;
}

+ (UIColor *)disabledTextColor
{
    static UIColor *_disabledTextColor = nil;
    if (!_disabledTextColor) {
        _disabledTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.26];
    }
    return _disabledTextColor;
}

+ (UIColor *)whiteDisabledTextColor
{
    static UIColor *_whiteDisabledTextColor = nil;
    if (!_whiteDisabledTextColor) {
        _whiteDisabledTextColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _whiteDisabledTextColor;
}

+ (UIColor *)dividersColor
{
    static UIColor *_dividersColor = nil;
    if (!_dividersColor) {
        _dividersColor = [[UIColor blackColor] colorWithAlphaComponent:0.12];
    }
    return _dividersColor;
}

+ (UIColor *)groupTableViewBgColor
{
    return [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1];
}

+ (UIColor *)keypadDeleteHighlightedColor
{
    return [UIColor colorWithRed:0.0f/255.0f green:70.0f/255.0f blue:125.0f/255.0f alpha:1];
}

+ (UIColor *)callEndColor
{
//    return [UIColor colorWithRed:252.0f/255.0f green:60.0f/255.0f blue:64.0f/255.0f alpha:1];
    return [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:58.0f/255.0f alpha:1];
}

+ (UIColor *)callAnswerColor
{
//    return [UIColor colorWithRed:38.0f/255.0f green:214.0f/255.0f blue:80.0f/255.0f alpha:1];
    return [UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1];
}

+ (UIColor *)loadingViewBgColor
{
    return [[UIColor blackColor] colorWithAlphaComponent:0.5];
}

+ (UIColor *)sectionHeaderBgColor
{
    return [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:0.8];;
}

+ (UIColor *)badgeViewBgColor
{
    return [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1];
}

+ (UIFont *)primaryTextFont
{
    static UIFont *_primaryTextFont = nil;
    if (!_primaryTextFont) {
        _primaryTextFont = [UIFont systemFontOfSize:18];
    }
    return _primaryTextFont;
}

+ (UIFont *)contactsTextFont
{
    return [UIFont boldSystemFontOfSize:18];
}

+ (UIColor *)color:(UIColor *)color withHueValue:(CGFloat)value
{
    CGFloat saturation, brightness, alpha;
    [color getHue:nil saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:value saturation:saturation brightness:brightness alpha:alpha];
}

+ (CGFloat)hueValueOfColor:(UIColor *)color
{
    CGFloat hue;
    [color getHue:&hue saturation:nil brightness:nil alpha:nil];
    return hue;
}

+ (UIColor *)color:(UIColor *)color withBrightnessValue:(CGFloat)value
{
    CGFloat hue, saturation, alpha;
    [color getHue:&hue saturation:&saturation brightness:nil alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:saturation brightness:value alpha:alpha];
}

+ (CGFloat)brightnessValueOfColor:(UIColor *)color
{
    CGFloat brightness;
    [color getHue:nil saturation:nil brightness:&brightness alpha:nil];
    return brightness;
}

+ (UIColor *)facebookColor
{
    return [UIColor colorWithRed:58.0f/255.0f green:88.0f/255.0f blue:152.0f/255.0f alpha:1];
}

+ (UIColor *)randomCallButtonColor
{
    return [UIColor colorWithRed:5.0f/255.0f green:201.0f/255.0f blue:216.0f/255.0f alpha:1];
}

+ (UIColor *)featureRandomCallColor
{
    return [UIColor colorWithRed:235.0f/255.0f green:88.0f/255.0f blue:76.0f/255.0f alpha:1];
}

+ (UIColor *)cameraOffBackgroundDarkColor
{
    return [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1];
}

+ (UIColor *)cameraOffBackgroundLightColor
{
    return [UIColor colorWithRed:70.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1];
}

+ (UIColor *)jusPointsColor
{
    return [UIColor colorWithRed:255.0f/255.0f green:192.0f/255.0f blue:6.0f/255.0f alpha:1];
}

+ (UIColor *)jusPointsTodayColor
{
    return [UIColor colorWithRed:204.0f/255.0f green:219.0f/255.0f blue:56.0f/255.0f alpha:1];
}

+ (UIColor *)jusPointsFutureColor
{
    return [UIColor colorWithRed:254.0f/255.0f green:229.0f/255.0f blue:159.0f/255.0f alpha:1];
}

+ (UIColor *)jusPointsBorderColor
{
    return [UIColor colorWithRed:112.0f/255.0f green:198.0f/255.0f blue:69.0f/255.0f alpha:1];
}

+ (NSArray *)doodleColorArray
{
    return @[//red
             [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1],
             //orange
             [UIColor colorWithRed:255.0f/255.0f green:121.0f/255.0f blue:0.0f/255.0f alpha:1],
             //yellow
             [UIColor colorWithRed:255.0f/255.0f green:241.0f/255.0f blue:0.0f/255.0f alpha:1],
             //green
             [UIColor colorWithRed:143.0f/255.0f green:195.0f/255.0f blue:31.0f/255.0f alpha:1],
             //blue
             [UIColor colorWithRed:1.0f/255.0f green:130.0f/255.0f blue:255.0f/255.0f alpha:1],
             //purple
             [UIColor colorWithRed:145.0f/255.0f green:0.0f/255.0f blue:239.0f/255.0f alpha:1],
             //magenta
             [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:148.0f/255.0f alpha:1],
             [UIColor colorWithRed:253.0f/255.0f green:165.0f/255.0f blue:165.0f/255.0f alpha:1],
             [UIColor colorWithRed:150.0f/255.0f green:190.0f/255.0f blue:214.0f/255.0f alpha:1],
             [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1],
             ];
}

+ (UIColor *)AdsNextButtonBackgroundColor {
    return [self skinColor];
}

+ (UIColor *)JusCommonColor
{
    return [UIColor blackColor];
}
@end
