//
//  UICommonDesign.m
//  JusAuto
//
//  Created by ju on 2017/3/2.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "UICommonDesign.h"

@implementation UICommonDesign
+ (UIImage *)backgroudViewImage
{
    UIImage *image = nil;
    if(IS_IPHONE5)
        {
        image = [UIImage imageNamed:@"background-1136"];
        }
    else if(IS_IPHONE6)
        {
        image = [UIImage imageNamed:@"background-1334"];
        }
    else if(IS_IPHONE6PLUS)
        {
        image = [UIImage imageNamed:@"background-2208"];
        }
    return image;
}

+ (UIColor *)getAvatarColor
{
    UIColor *color1 = [UIColor colorWithRed:36.f/255.f green:141.f/255.f blue:211.f/255.f alpha:1.f];
    UIColor *color2 = [UIColor colorWithRed:0.f/255.f green:150.f/255.f blue:136.f/255.f alpha:1.f];
    UIColor *color3 = [UIColor colorWithRed:234.f/255.f green:170.f/255.f blue:27.f/255.f alpha:1.f];
    UIColor *color4 = [UIColor colorWithRed:0.f/255.f green:188.f/255.f blue:212.f/255.f alpha:1.f];
    UIColor *color5 = [UIColor colorWithRed:126.f/255.f green:87.f/255.f blue:194.f/255.f alpha:1.f];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:color1];
    [array addObject:color2];
    [array addObject:color3];
    [array addObject:color4];
    [array addObject:color5];
    
    int x = arc4random() % 5;
    
    UIColor *randomcolor =  [array objectAtIndex:x];
    
    return randomcolor;
}

+ (UIImage *)backgroudDefaultImage
{
    UIImage *image = nil;
    if(IS_IPHONE5)
    {
        image = [UIImage imageNamed:@"default-568h"];
    }
    else if(IS_IPHONE6)
    {
        image = [UIImage imageNamed:@"default-667h"];
    }
    else if(IS_IPHONE6PLUS)
    {
        image = [UIImage imageNamed:@"default-736h"];
    }
    else
    {
        image = [UIImage imageNamed:@"default"];
    }
    return image;
}　
@end
