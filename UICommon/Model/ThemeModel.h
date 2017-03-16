//
//  ThemeModel.h
//  JusTalk
//
//  Created by LD on 16/7/27.
//  Copyright © 2016年 juphoon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kThemeVersion ThemeVersion  // add one when theme has new update
#define kThemeVersionKey @"ThemeVersionKey"


@interface ThemeModel : NSObject <NSCopying,NSCoding>
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) UIColor  *color;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *thumbnailImageName;
@property (nonatomic,copy) NSString *aboutImageName;
@property (nonatomic,copy) NSString *launchImageName;
@property (nonatomic,assign) BOOL    shouldAddMaskForLaunchView;
-(UIImage *)thumbnailImage;
-(UIImage *)image;
-(UIImage *)aboutImage;
-(UIImage *)launchImage;

+(instancetype)themeWithName:(NSString *)aName
                       color:(UIColor *)aColor
                   imageName:(NSString *)aImageName
          thumbnailImageName:(NSString *)aThumbnailImageName
              aboutImageName:(NSString *)aAboutImageName
             launchImageName:(NSString *)aLaunchImageName
  shouldAddMaskForLaunchView:(BOOL)shouldAddMaskForLaunchView;

+(instancetype)customeColorThemeWithColor:(UIColor *)aColor;

- (void)applyToNavigationController:(UINavigationController*)navigationController saveToUserDefault:(BOOL)save;
- (void)saveThemeToUserDefaults;
- (void)changeColor:(UIColor *)aColor;
- (BOOL)isCustomColorTheme;

+ (ThemeModel *)presentTheme;
+ (ThemeModel *)convertFromColor:(UIColor*)aColor;
+ (ThemeModel *)convertFromName:(NSString*)aName color:(UIColor*)aColor;

NSString *imagePathWithName(NSString *name);

//Local Theme
+ (NSArray<__kindof ThemeModel *>*)allLocalThemes;
//festival
+ (ThemeModel *)fatherDay;
+ (ThemeModel *)montherDay;
+ (ThemeModel *)childrenDay;
+ (ThemeModel *)valentineDay;
+ (ThemeModel *)yearOfMonkey;
+ (ThemeModel *)magpieFestival;
+ (ThemeModel *)yearOfRooster;

//Pure Color
- (BOOL)isLocalColorTheme;

+(ThemeModel *)classicBlue;
+(ThemeModel *)pink;
+(ThemeModel *)purple;
+(ThemeModel *)indigo;
+(ThemeModel *)blue;
//+(ThemeModel *)cyan;
+(ThemeModel *)green;
+(ThemeModel *)amber;
+(ThemeModel *)orange;
+(ThemeModel *)deepOrange;
@end
