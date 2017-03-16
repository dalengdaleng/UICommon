//
//  AlertSelfView.h
//  JusAuto
//
//  Created by ju on 2017/2/14.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertSelfView : NSObject
+ (AlertSelfView *)shareInstance;

- (void)showAlertView:(UIViewController *)viewController
                                    title:(NSString *)title 
                                    messsage:(NSString *)message 
                                    cancelTitle:(NSString *)cancelButtonTitle 
                                    otherTitle:(NSString *)otherButtonTitle 
                                    confirmAction:(void (^)())confirm 
                                    cancelAction:(void (^)())cancle;
                                    
/**
 * 有输入框
 */
+ (void)addTextFieldWithTitle:(NSString *)title
                      message:(NSString *)message
                    rightName:(NSString *)rightName
                     leftName:(NSString *)leftName
                  placeholder:(NSString *)placeholder
                         text:(NSString *)text
               viewController:(UIViewController *)viewController
                  rightAction:(void (^)(NSString *text))rightAction
                   leftAction:(void (^)(NSString *text))leftAction;
@end
