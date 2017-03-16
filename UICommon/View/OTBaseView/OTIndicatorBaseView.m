//
//  OTIndicatorBaseView.m
//  PRIS_iPhone
//
//  Created by king.wu on 12/3/14.
//
//

#import "OTIndicatorBaseView.h"
#import "OTIndicatorBaseWindow.h"

@interface OTIndicatorBaseView ()

@property (retain, nonatomic)OTIndicatorBaseWindow *baseWindow;
@property (assign, nonatomic)CGFloat rotateDegree;

@end

@implementation OTIndicatorBaseView

/**
 *  初始化一个OTIndicatorBaseView 实例
 *
 *  @param customView 用户自定义的View
 *
 *  @return OTIndicatorBaseView 实例
 */
- (id)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        OTIndicatorBaseWindow *window = [[OTIndicatorBaseWindow alloc]initIndicatorWindowWithType:OTIndicatorWindowStyleBlack];
        self.baseWindow = window;

        [self.baseWindow addSubview:self];
        [self.baseWindow addSubview:customView];
    }
    return self;
}

/**
 *  显示IndicatorView
 */
- (void)show
{
    [self.baseWindow resetToOriginDegree];
    [self.baseWindow rotateWindow:self.rotateDegree];
    [self.baseWindow showWindowWithAimated:YES completion:^(BOOL finished) {
        
    }];

}

/**
 *  显示后，自动隐藏
 */
- (void)showAutoHiden
{
    [self show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideIndicatorBaseView:YES];
    });
}

/**
 *  隐藏IndicatorView
 *
 *  @param animated 是否有动画
 */
- (void)hideIndicatorBaseView:(BOOL)animated
{
    [self.baseWindow hiddeWindowWithAimated:animated completion:^(BOOL finished) {
        self.baseWindow = nil;
    }];
}

//旋转indicatoView
- (void)rotateIndicatorBaseView:(CGFloat)rotateDegree
{
    self.rotateDegree = rotateDegree;
    
    if (self.baseWindow != nil)
    {
        [self.baseWindow rotateWindow:rotateDegree];
    }
}

- (void)dealloc
{
    self.baseWindow = nil;
}

@end
