//
//  UIView+PanGesture.h
//  JusAuto
//
//  Created by ju on 2017/2/9.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PanGestureDelegate <NSObject>

@optional

- (void)panGesture:(UIPanGestureRecognizer *)panGesture didChangeWithView:(UIView *)targetView;
- (void)panGesture:(UIPanGestureRecognizer *)panGesture willShowTargetView:(UIView *)targetView;
- (void)panGesture:(UIPanGestureRecognizer *)panGesture didShowTargetView:(UIView *)targetView;
- (void)panGesture:(UIPanGestureRecognizer *)panGesture willHideTargetView:(UIView *)targetView;
- (void)panGesture:(UIPanGestureRecognizer *)panGesture didHideTargetView:(UIView *)targetView;

@end

@interface UIView (PanGesture)
@property (nonatomic, assign) id<PanGestureDelegate> panGestureDelegate;

/**
 *  注意这个方法必须放在view被add到subView上之后调用,因为里面会用到view.superView
 *  在iOS8的6或者6+上，这个方法需放到viewDidAppear里面，因为动画是改frame的，而layout在viewDidAppear的时候才会确定正确的frame
 */
- (void)addPanGestureWithEndFrame:(CGRect)endFrame;

- (void)showGesturedViewWithCompletedBlock:(void(^)(BOOL isFinished))completedBlock;

- (void)hideGesturedViewWithCompletedBlock:(void(^)(BOOL isFinished))completedBlock;
@end
