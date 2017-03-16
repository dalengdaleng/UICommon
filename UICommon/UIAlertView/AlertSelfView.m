//
//  AlertSelfView.m
//  JusAuto
//
//  Created by ju on 2017/2/14.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "AlertSelfView.h"

typedef void (^confirm)();
typedef void (^cancle)();

@interface AlertSelfView()
{
    confirm confirmParam;
    cancle  cancleParam;
}
@end

@implementation AlertSelfView

+ (AlertSelfView *)shareInstance
{
    static AlertSelfView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance)
            {
                instance = [[AlertSelfView alloc] init];
            
            }
    });
    return instance;
}

- (void)showAlertView:(UIViewController *)viewController
                title:(NSString *)title 
             messsage:(NSString *)message 
          cancelTitle:(NSString *)cancelButtonTitle 
           otherTitle:(NSString *)otherButtonTitle 
        confirmAction:(void (^)())confirm 
         cancelAction:(void (^)())cancle
{
    confirmParam = confirm;
    cancleParam = cancle;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Add the actions.
        UIAlertAction *cancelAction = nil;
        if([cancelButtonTitle length] > 0)
        {
            cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                cancle();
            }];
            [alertController addAction:cancelAction];
        }
        
        UIAlertAction *otherAction = nil;
        if([otherButtonTitle length] > 0)
        {
            otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                confirm();
            }];
            [alertController addAction:otherAction];
        }
        alertController.preferredAction = cancelAction;
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertView *TitleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle,nil];
        [TitleAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        cancleParam();
    }
    else{
        confirmParam();
    }
}

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
                  rightAction:(void (^)(NSString *))rightAction
                   leftAction:(void (^)(NSString *))leftAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        textField.text = text;
    }];
    
    UIAlertAction *right=[UIAlertAction actionWithTitle:rightName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UITextField *textField = alertController.textFields.firstObject;
        if (rightAction) {
            rightAction(textField.text);
        }
    }];
    
    UIAlertAction *left=[UIAlertAction actionWithTitle:leftName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UITextField *textField = alertController.textFields.firstObject;
        if (leftAction) {
            leftAction(textField.text);
        }
    }];
    
    [alertController addAction:left];
    [alertController addAction:right];
    
    alertController.preferredAction = left;
    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end
