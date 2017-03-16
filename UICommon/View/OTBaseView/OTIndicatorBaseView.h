//
//  OTIndicatorBaseView.h
//  PRIS_iPhone
//
//  Created by king.wu on 12/3/14.
//
//

//自定义的IndicatorBaseView，用户自己定义的view贴在这个OTIndicatorBaseView显示
//使用方法:
/*
    初始化、显示
    UIView *customView = [[UIView alloc] init];
    
    OTIndicatorBaseView *indicatorView = [[OTIndicatorBaseView alloc] initWithCustomView:customView];
    [indicaotrview show];
    [indicatorView release];
 
    [customView release];
 
    //隐藏
    [indicatorView hideIndicatorBaseView:YES];
*/

#import <UIKit/UIKit.h>

@interface OTIndicatorBaseView : UIView

/**
 *  初始化一个OTIndicatorBaseView 实例
 *
 *  @param customView 用户自定义的View
 *
 *  @return OTIndicatorBaseView 实例
 */
- (id)initWithCustomView:(UIView *)customView;


/**
 *  显示IndicatorView
 */
- (void)show;

/**
 *  显示后，自动隐藏
 */
- (void)showAutoHiden;

/**
 *  隐藏IndicatorView
 *
 *  @param animated 是否有动画
 */
- (void)hideIndicatorBaseView:(BOOL)animated;

/**
 *  旋转IndicatorView
 *
 *  @param rotateDegree 选中的角度，单位弧度，如 M_PI_2 (pi/2)，
 */
- (void)rotateIndicatorBaseView:(CGFloat)rotateDegree;

@end
