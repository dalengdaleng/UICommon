//
//  ThemeModel.m
//  JusTalk
//
//  Created by LD on 16/7/27.
//  Copyright © 2016年 juphoon. All rights reserved.
//

#import "ThemeModel.h"
//#import "Versions.h"

// old Key
#define kThemeImageKey @"ThemeImage1"
#define kSkinColorKey @"SkinColor1"

#define KThemeKey @"ThemeKey"
#define KCustomColorThemeTitle @"CustomColorTheme" //customColor's theme title

//local theme name
#define kStringTheme_FatherDay @"Father day"
#define kStringTheme_MotherDay @"Mother day"
#define kStringTheme_ChildrenDay @"Children day"
#define kStringTheme_Valentine @"Valentine day"
#define kStringTheme_Easter @"Easter"
#define kStringTheme_Classic_blue @"Classic blue"
#define kStringTheme_Qixi_Festival @"Qixi Festival"
#define kStringTheme_Year_Of_Monkey @"Year of Monkey"
#define kStringTheme_Spring_Festival @"Spring Festival"

#define kPureColorThemeImageName @"launch-bg"
static NSString *suffix;

@implementation ThemeModel

#pragma mark - NSCoding Delegate
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_color forKey:@"color"];
    [aCoder encodeObject:_imageName forKey:@"imageName"];
    [aCoder encodeObject:_aboutImageName forKey:@"aboutImageName"];
    [aCoder encodeObject:_thumbnailImageName forKey:@"thumbnailImageName"];
    [aCoder encodeObject:_launchImageName forKey:@"launchImageName"];
    [aCoder encodeBool:_shouldAddMaskForLaunchView forKey:@"shouldAddMaskForLaunchView"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _name  = [aDecoder decodeObjectForKey:@"name"];
        _color = [aDecoder decodeObjectForKey:@"color"];
        _imageName = [aDecoder decodeObjectForKey:@"imageName"];
        _aboutImageName = [aDecoder decodeObjectForKey:@"aboutImageName"];
        _thumbnailImageName = [aDecoder decodeObjectForKey:@"thumbnailImageName"];
        _launchImageName = [aDecoder decodeObjectForKey:@"launchImageName"];
        _shouldAddMaskForLaunchView = [aDecoder decodeBoolForKey:@"shouldAddMaskForLaunchView"];
    }
    return self;
}

#pragma mark - init function
-(instancetype)initWithName:(NSString *)aName
                      color:(UIColor *)aColor
                  imageName:(NSString *)aImageName
         thumbnailImageName:(NSString *)aThumbnailImageName
             aboutImageName:(NSString *)aAboutImageName
            launchImageName:(NSString *)aLaunchImageName
 shouldAddMaskForLaunchView:(BOOL)shouldAddMaskForLaunchView;
{
    if (self = [super init]) {
        _name  = aName;
        _color = aColor;
        _imageName = aImageName;
        _thumbnailImageName = aThumbnailImageName;
        _aboutImageName     = aAboutImageName;
        _launchImageName    = aLaunchImageName;
        _shouldAddMaskForLaunchView = shouldAddMaskForLaunchView;
    }
    return self;
}

+(instancetype)themeWithName:(NSString *)aName
                       color:(UIColor *)aColor
                   imageName:(NSString *)aImageName
          thumbnailImageName:(NSString *)aThumbnailImageName
              aboutImageName:(NSString *)aAboutImageName
             launchImageName:(NSString *)aLaunchImageName
  shouldAddMaskForLaunchView:(BOOL)shouldAddMaskForLaunchView;
{
    ThemeModel *model = [[ThemeModel alloc]initWithName:aName
                                                  color:aColor
                                              imageName:aImageName
                                     thumbnailImageName:aThumbnailImageName
                                         aboutImageName:aAboutImageName
                                        launchImageName:aLaunchImageName
                             shouldAddMaskForLaunchView:shouldAddMaskForLaunchView];
    return model;
}

+(instancetype)colorThemeWithName:(NSString *)aName
                            color:(UIColor *)aColor
               thumbnailImageName:(NSString*)aThumbnailImageName
{
    ThemeModel *model = [[ThemeModel alloc]initWithName:aName
                                                  color:aColor
                                              imageName:nil
                                     thumbnailImageName:aThumbnailImageName
                                         aboutImageName:nil
                                        launchImageName:kPureColorThemeImageName
                             shouldAddMaskForLaunchView:YES];
    return model;
}

+(instancetype)customeColorThemeWithColor:(UIColor *)aColor{
    ThemeModel *model = [ThemeModel colorThemeWithName:KCustomColorThemeTitle color:aColor thumbnailImageName:nil];
    return model;
}

#pragma mark - public function
-(void)applyToNavigationController:(UINavigationController*)navigationController saveToUserDefault:(BOOL)save{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        navigationController.navigationBar.tintColor = _color;
    } else {
        navigationController.navigationBar.barTintColor = _color;
    }
    [navigationController.navigationBar setBackgroundImage:self.image forBarMetrics:UIBarMetricsDefault];
    if (save) {
        [self saveThemeToUserDefaults];
    }
}

-(void)saveThemeToUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *themeData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [userDefaults setObject:themeData forKey:KThemeKey];
}

-(void)changeColor:(UIColor *)color{
    _color = color;
    _name = KCustomColorThemeTitle;
    _imageName = nil;
    _aboutImageName = nil;
    _thumbnailImageName = nil;
    _launchImageName = kPureColorThemeImageName;
    _shouldAddMaskForLaunchView = YES;
}

+(ThemeModel *)presentTheme{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:KThemeKey];
    if (data) {
        ThemeModel *theme = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (!theme.launchImageName) {
            // update for mask View
            ThemeModel *updateTheme = [ThemeModel convertFromName:theme.name color:theme.color];
            [updateTheme saveThemeToUserDefaults];
            return updateTheme;
        }
        NSInteger oldVersion = [[NSUserDefaults standardUserDefaults] integerForKey:kThemeVersionKey];
        if (oldVersion < 4) {
            if ([theme.name isEqualToString:kStringTheme_Spring_Festival]) {
                theme = [ThemeModel yearOfRooster];
                [theme saveThemeToUserDefaults];
            }
        }
        return theme;
    } else {
        
        NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:kSkinColorKey];
        if (colorData) {
            //update theme
            UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
            ThemeModel *theme = [ThemeModel convertFromColor:color];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSkinColorKey];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kThemeImageKey];
            [theme saveThemeToUserDefaults];
            return theme;
        } else {
            return nil;
        }
    }
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other class]==[ThemeModel class]) {
        if (self.name==nil ||
            ((ThemeModel*)other).name==nil) {
            return NO;
        } else if ([self.name isEqualToString:KCustomColorThemeTitle] ||
                   [((ThemeModel*)other).name isEqualToString:KCustomColorThemeTitle]){
            return NO;
        } else {
            return [self.name isEqual:((ThemeModel*)other).name];
        }
    } else {
        return NO;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    ThemeModel *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [_name copy];
    copy.imageName = [_imageName copy];
    copy.thumbnailImageName = [_thumbnailImageName copy];
    copy.aboutImageName = [_aboutImageName copy];
    copy.color = [_color copy];
    copy.shouldAddMaskForLaunchView = _shouldAddMaskForLaunchView;
    return copy;
}

+(ThemeModel *)convertFromColor:(UIColor*)aColor{
    NSArray *localThemes = [ThemeModel allLocalThemes];
    for (ThemeModel *temp in localThemes) {
        if ([temp.color isEqual:aColor]) {
            return temp;
        }
    }
    return [ThemeModel customeColorThemeWithColor:aColor];
}

+ (ThemeModel *)convertFromName:(NSString*)aName color:(UIColor*)aColor{
    NSArray *localThemes = [ThemeModel allLocalThemes];
    for (ThemeModel *temp in localThemes) {
        if ([temp.name isEqual:aName]) {
            return temp;
        }
    }
    return [ThemeModel customeColorThemeWithColor:aColor];
}

-(UIImage *)thumbnailImage{
    if (_thumbnailImageName) {
        return [UIImage imageWithContentsOfFile:imagePathWithName(_thumbnailImageName)];
    } else {
        return nil;
    }
}

-(UIImage *)image{
    if (_imageName) {
        return [UIImage imageWithContentsOfFile:imagePathWithName(_imageName)];
    } else {
        return nil;
    }
}

-(UIImage *)aboutImage{
    if (_aboutImageName) {
        return [UIImage imageWithContentsOfFile:imagePathWithName(_aboutImageName)];
    } else {
        if (_imageName) {
            return [UIImage imageWithContentsOfFile:imagePathWithName(_imageName)];
        } else {
            return nil;
        }
    }
}

-(UIImage *)launchImage{
    if (_launchImageName) {
        return [UIImage imageWithContentsOfFile:imagePathWithName(_launchImageName)];
    } else {
        return nil;
    }
}

NSString *imagePathWithName(NSString *name) {
    NSString *fullName = name;
    //Search mainBundle
    //imageName need @2x
    int scale = [[UIScreen mainScreen]scale];
    switch (scale) {
        case 2:
            fullName = [name stringByAppendingString:@"@2x"];
            break;
        case 3:
            fullName = [name stringByAppendingString:@"@3x"];
            break;
        default:
            break;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:fullName ofType:@"png"];
    if (!path) {
        fullName = [name stringByAppendingString:@"@2x"];
        path = [[NSBundle mainBundle] pathForResource:fullName ofType:@"png"];
    }
    if (!path) {
        fullName = [name stringByAppendingString:@"@3x"];
        path = [[NSBundle mainBundle] pathForResource:fullName ofType:@"png"];
    }
    if (!path) {
        //Search Library
        
        /*
         *
         *
         */
    }
    return path;
}

#pragma mark - Local Theme
+(NSArray<__kindof ThemeModel *>*)allLocalThemes{
    return  @[
              [ThemeModel fatherDay],
              [ThemeModel montherDay],
              [ThemeModel childrenDay],
              [ThemeModel valentineDay],
              [ThemeModel yearOfRooster],
              [ThemeModel yearOfMonkey],
              [ThemeModel magpieFestival],
              [ThemeModel classicBlue],
              [ThemeModel pink],
              [ThemeModel purple],
              [ThemeModel indigo],
              [ThemeModel blue],
              [ThemeModel green],
              [ThemeModel amber],
              [ThemeModel orange],
              [ThemeModel deepOrange],
              ];
}

+ (NSString *)getImageSufixDependScreenHeight{
    NSString *suffix = @"";
    if (IS_IPHONE6PLUS) {
        suffix = @"-736h";
    } else if (IS_IPHONE6) {
        suffix = @"-667h";
    } else if (IS_IPHONE5) {
        suffix = @"-568h";
    }
    return suffix;
}

#pragma mark - festival Theme
+ (ThemeModel *)fatherDay{
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_FatherDay
                                            color:[UIColor colorWithRed:0.0f/255.0f green:162.0f/255.0f blue:154.0f/255.0f alpha:1]
                                        imageName:[@"theme-father-day" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-FatherDay"
                                   aboutImageName:[@"theme-father-day-about" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-father-day" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+(ThemeModel *)montherDay{
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_MotherDay
                                            color:[UIColor colorWithRed:239.0f/255.0f green:130.0f/255.0f blue:155.0f/255.0f alpha:1]
                                        imageName:[@"theme-motherday" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-Motherday"
                                   aboutImageName:[@"theme-motherday" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-motherday" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+(ThemeModel *)childrenDay{
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_ChildrenDay
                                            color:[UIColor colorWithRed:76.0f/255.0f green:106.0f/255.0f blue:214.0f/255.0f alpha:1]
                                        imageName:[@"theme-children-day" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-ChildrenDay"
                                   aboutImageName:[@"theme-children-day" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-children-day" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+(ThemeModel *)valentineDay{
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_Valentine
                                            color:[UIColor colorWithRed:255.0f/255.0f green:74.0f/255.0f blue:113.0f/255.0f alpha:1]
                                        imageName:[@"theme-valentine" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-Valentine"
                                   aboutImageName:[@"theme-valentine" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-valentine" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+(ThemeModel *)magpieFestival {
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_Qixi_Festival
                                            color:[UIColor colorWithRed:200.0f/255.0f green:84.0f/255.0f blue:190.0f/255.0f alpha:1]
                                        imageName:[@"theme-Magpie_Festival" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-Magpie_Festival"
                                   aboutImageName:[@"theme-Magpie_Festival" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-Magpie_Festival" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+(ThemeModel *)yearOfMonkey {
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_Year_Of_Monkey
                                            color:[UIColor colorWithRed:232.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1]
                                        imageName:[@"theme-year_of_monkey" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-year_of_monkey"
                                   aboutImageName:[@"theme-year_of_monkey" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-year_of_monkey" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+ (ThemeModel *)yearOfRooster {
    suffix = [ThemeModel getImageSufixDependScreenHeight];
    ThemeModel *model = [ThemeModel themeWithName:kStringTheme_Spring_Festival
                                            color:[UIColor colorWithRed:232.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1]
                                        imageName:[@"theme-year_of_rooster" stringByAppendingString:suffix]
                               thumbnailImageName:@"Thumbnail-year_of_rooster"
                                   aboutImageName:[@"theme-year_of_rooster" stringByAppendingString:suffix]
                                  launchImageName:[@"theme-year_of_rooster" stringByAppendingString:suffix]
                       shouldAddMaskForLaunchView:NO];
    return model;
}

+(ThemeModel *)classicBlue{
    return [ThemeModel colorThemeWithName:kStringTheme_Classic_blue
                                    color:[UIColor colorWithRed:0.0f/255.0f green:188.0f/255.0f blue:212.0f/255.0f alpha:1]
                       thumbnailImageName:@"Thumbnail-classic_blue"];
}

#pragma mark - Pure Color Theme
//add this array when local pure color has new
-(BOOL)isLocalColorTheme{
    NSArray * array = @[@"localPink",
                        @"localPurple",
                        @"localIndigo",
                        @"localBlue",
                        @"localGreen",
                        @"localAmber",
                        @"localOrange",
                        @"localDeepOrange",
                        ];
    return [array containsObject:self.name];
}

-(BOOL)isCustomColorTheme{
    return [KCustomColorThemeTitle isEqualToString:self.name];
}

+(ThemeModel *)pink{
    UIColor *color = [UIColor colorWithRed:233.0f/255.0f green:30.0f/255.0f blue:99.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localPink"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

+(ThemeModel *)purple{
    UIColor *color = [UIColor colorWithRed:156.0f/255.0f green:39.0f/255.0f blue:176.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localPurple"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

+(ThemeModel *)indigo{
    UIColor *color = [UIColor colorWithRed:63.0f/255.0f green:81.0f/255.0f blue:181.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localIndigo"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

+(ThemeModel *)blue{
    UIColor *color = [UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:235.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localBlue"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

//+(ThemeModel *)cyan{
//    UIColor *color = [UIColor colorWithRed:0.0f/255.0f green:188.0f/255.0f blue:212.0f/255.0f alpha:1];
//    ThemeModel *model = [ThemeModel colorThemeWithName:@"localCyan"
//                                            color:color
//                               thumbnailImageName:nil];
//    return model;
//}

+(ThemeModel *)green{
    UIColor *color = [UIColor colorWithRed:76.0f/255.0f green:175.0f/255.0f blue:80.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localGreen"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

+(ThemeModel *)amber{
    UIColor *color = [UIColor colorWithRed:255.0f/255.0f green:193.0f/255.0f blue:7.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localAmber"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

+(ThemeModel *)orange{
    UIColor *color = [UIColor colorWithRed:255.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localOrange"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}

+(ThemeModel *)deepOrange{
    UIColor *color = [UIColor colorWithRed:255.0f/255.0f green:87.0f/255.0f blue:34.0f/255.0f alpha:1];
    ThemeModel *model = [ThemeModel colorThemeWithName:@"localDeepOrange"
                                                 color:color
                                    thumbnailImageName:nil];
    return model;
}
@end
