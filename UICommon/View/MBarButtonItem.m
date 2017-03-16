//
//  MBarButtonItem.m
//  JusAuto
//
//  Created by ju on 2017/2/10.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "MBarButtonItem.h"
#import "EnlargeEdgeButton.h"

@implementation MBarButtonItem
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)aTitle target:(id)target action:(SEL)action
{
    EnlargeEdgeButton *button = [EnlargeEdgeButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:255.f/255.f alpha:0.5f] forState:UIControlStateHighlighted];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10.f, 0.f, 0.f)];

//    if (imageName) {
//        UIImage *image = [UIImage imageNamed:imageName];
//        [button setImage:[image imageWithColor:[Settings skinColor]] forState:UIControlStateNormal];
//        [button setImage:[image imageWithColor:[Settings highlightedSkinColor]] forState:UIControlStateHighlighted];
//    }
    CGRect buttonFrame = [button frame];
    if(aTitle.length > 0)
    {
        buttonFrame.size.width = [aTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f]}].width;
    }
    else
    {
        buttonFrame.size.width = 42.f;
    }
    buttonFrame.size.height = 43.f;
    [button setFrame:buttonFrame];
    
    [button setEnlargeEdgeWithTop:20.f right:20.f bottom:20.f left:20.f];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
