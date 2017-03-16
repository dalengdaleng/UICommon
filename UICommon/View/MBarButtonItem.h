//
//  MBarButtonItem.h
//  JusAuto
//
//  Created by ju on 2017/2/10.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBarButtonItem : NSObject
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)aTitle target:(id)target action:(SEL)action;
@end
