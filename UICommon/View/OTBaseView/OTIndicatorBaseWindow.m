//
//  OTIndicatorBaseWindow.m
//  PRIS_iPhone
//
//  Created by king.wu on 11/26/14.
//
//

#import "OTIndicatorBaseWindow.h"

@interface OTIndicatorBaseWindow ()

@property (strong, nonatomic) UIWindow *privateWindow;     // 包含框框的window,window是个正方形，边长是屏幕宽高 大的那个。
@property (strong, nonatomic) UIView *backgroundView;//背景的view

@end

@implementation OTIndicatorBaseWindow

- (id)initIndicatorWindowWithType:(IndicatorWindowType)type
{
    self = [super init];
    if (self)
    {
        _windowType = type;
        [self initWindow];
        [self initBackgroundViewWithType:self.windowType];
    }
    
    return self;
    
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _windowType = OTIndicatorWindowStyleDefault;
        
        [self initWindow];
        [self initBackgroundViewWithType:self.windowType];
    }
    
    return self;
}

- (void)initWindow
{
    CGRect screenBounds =[[UIScreen mainScreen] bounds];
    CGFloat maxSize = MAX(screenBounds.size.width, screenBounds.size.height);
    UIWindow *window= [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, maxSize, maxSize)];
    window.center = CGPointMake(screenBounds.size.width/2, screenBounds.size.height/2);
    
//    [window setWindowLevel:UIWindowLevelStatusBar + 1];
    window.hidden = YES;
    window.backgroundColor = [UIColor clearColor];
    window.rootViewController = [[UIViewController alloc] init];
    self.privateWindow = window;

}

- (void)initBackgroundViewWithType:(IndicatorWindowType)windowType
{
    if (self.backgroundView == nil)
    {
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.privateWindow.frame.size.width, self.privateWindow.frame.size.height)];
        self.backgroundView = backgroundView;
    }
    
    switch (windowType) {
        case OTIndicatorWindowStyleDefault:
            self.backgroundView.alpha = 0.0;
            self.backgroundView.backgroundColor = [UIColor blackColor];
            break;
        case OTIndicatorWindowStyleBlack:
            self.backgroundView.alpha = 0.5;
            self.backgroundView.backgroundColor = [UIColor blackColor];
            break;
        default:
            break;
    }
    
    [self.privateWindow addSubview:self.backgroundView];
}

- (void)dealloc
{
    self.privateWindow = nil;
    self.backgroundView = nil;
}


/**
 *  显示window
 *
 *  @param animated 是否播放动画
 */
- (void)showWindowWithAimated:(BOOL)animated completion:(OTBaseWindowAnimationCompleteBock)block
{
    if (animated == YES)
    {
        self.privateWindow.hidden = NO;
        self.privateWindow.alpha = 0.0;
        [UIView transitionWithView:self.privateWindow
                          duration:0.2
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.privateWindow.alpha = 1.0;
                        }
                        completion:^(BOOL finished) {
                            
                            block(finished);
                        }];

    }
    else
    {
        self.privateWindow.hidden = NO;
        self.privateWindow.alpha = 1.0;
        block(YES);
    }
}

/**
 *  隐藏window
 *
 *  @param animated 是否播放动画
 */
- (void)hiddeWindowWithAimated:(BOOL)animated completion:(OTBaseWindowAnimationCompleteBock)block
{
    if (animated == YES)
    {
        [UIView transitionWithView:self.privateWindow
                          duration:0.15
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.privateWindow.alpha = 0.0;
                        }
                        completion:^(BOOL finished) {
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                block(finished);
                            });
                        }];
    }
    else
    {
        self.privateWindow.hidden = YES;
        block(YES);
    }

}

/**
 *  旋转window
 *
 *  @param rotate 选中的角度，单位弧度，如 M_PI_2 (pi/2)
 */
- (void)rotateWindow:(CGFloat)rotateDegree
{
    self.privateWindow.transform = CGAffineTransformMakeRotation(rotateDegree);
}


/**
 *  window恢复到初始化是的角度
 */
- (void)resetToOriginDegree
{
    self.privateWindow.transform = CGAffineTransformIdentity;
}


/**
 *  是否接收用户的事件
 *
 *  @return bool值
 */
- (BOOL)isUserInteractionEnabled
{
    return _privateWindow.isUserInteractionEnabled;
}

/**
 *  设置是否接收用户的事件
 *
 *  @param userInteractionEnabled Yes：接收  NO：不接收
 */
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    _privateWindow.userInteractionEnabled = userInteractionEnabled;
}

/**
 *  设置window的 type
 *
 *  @param windowType windowType的类型
 */
- (void)setWindowType:(IndicatorWindowType)windowType
{
    _windowType = windowType;
    
    [self initBackgroundViewWithType:windowType];
}

/**
 *  加入子的view
 *
 *  @param subView 子的view
 */
- (void)addSubview:(UIView *)subView
{
    subView.center = self.backgroundView.center;
    [self.privateWindow addSubview:subView];
}

/**
 *  根据tag，移除一个子的view
 *
 *  @param tag view的tag标记
 */
- (void)removeSubViewBuyTag:(NSInteger)tag
{
    UIView *subView = [self.privateWindow viewWithTag:tag];
    [subView removeFromSuperview];
}


/**
 *  根据tag，找到一个子的view
 *
 *  @param tag view的tag标记
 *
 *  @return 返回一个子view
 */
- (UIView *)viewWithTag:(NSInteger)tag
{
    return [self.privateWindow viewWithTag:tag];
}
/**
 *  设置window的级别
 *
 *  @param aLevel window级别
 */
- (void)setPrivateWindowLevel:(NSInteger)aLevel
{
    [self.privateWindow setWindowLevel:UIWindowLevelStatusBar + aLevel];
}

@end
