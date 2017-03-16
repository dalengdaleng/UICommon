//
//  OTIndicatorBaseWindow.h
//  PRIS_iPhone
//
//  Created by king.wu on 11/26/14.
//
//

/**
 *  从4.7.0版本开始，阅读里的提示框统一写，这个类提供一个window,实现一个 显示 和 退出 的效果，
 *  提示框一般为View，View贴在这个这个window显示
 */



#import <Foundation/Foundation.h>


//window Hide完成的block
typedef  void(^OTBaseWindowAnimationCompleteBock)(BOOL finished);

typedef NS_ENUM(NSUInteger, IndicatorWindowType) {
    
    OTIndicatorWindowStyleDefault    = 0 ,   // 没有背景色
    OTIndicatorWindowStyleBlack      = 1 ,   // 底色是黑色，0.5的透明度
};


@interface OTIndicatorBaseWindow : NSObject

@property (assign, nonatomic)IndicatorWindowType windowType;//window的类型

@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;

/**
 *  初始化window，
 *
 *  @param type window的类型
 */
- (id)initIndicatorWindowWithType:(IndicatorWindowType)type;

/**
 *  显示window
 *
 *  @param animated 是否播放动画
 *  @param block window显示完成后的 block，一般在这里释放掉 所创建的OTIndicatorBaseWindow
 */
- (void)showWindowWithAimated:(BOOL)animated completion:(OTBaseWindowAnimationCompleteBock)block;

/**
 *  隐藏window
 *
 *  @param animated 是否播放动画
 *  @param block window隐藏后的 block，一般在这里释放掉 所创建的OTIndicatorBaseWindow
 */
- (void)hiddeWindowWithAimated:(BOOL)animated completion:(OTBaseWindowAnimationCompleteBock)block;

/**
 *  旋转window
 *
 *  @param rotateDegree 选中的角度，单位弧度，如 M_PI_2 (pi/2)，
 * 
 *  attention: 如果旋转了window的角度，且这个window是一个你自己创建的单例，则一定在退出的时候，通过调用resetToOriginDegree，将角度恢复到初始化的值，否则别人调用很可能出错
 */
- (void)rotateWindow:(CGFloat)rotateDegree;


/**
 *  window恢复到初始化时的角度
 */
- (void)resetToOriginDegree;



/**
 *  是否接收用户的事件
 *
 *  @return bool值
 */
- (BOOL)isUserInteractionEnabled;

/**
 *  设置是否接收用户的事件
 *
 *  @param userInteractionEnabled Yes：接收  NO：不接收
 */
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled;



/**
 *  加入子的view
 *
 *  @param subView 子的view，
 *  @param 加入后，都居中显示，自己设置的位置没用
 */
- (void)addSubview:(UIView *)subView;

/**
 *  根据tag，移除一个子的view
 *
 *  @param tag view的tag标记
 */
- (void)removeSubViewBuyTag:(NSInteger)tag;

/**
 *  根据tag，找到一个子的view
 *
 *  @param tag view的tag标记
 *
 *  @return 返回一个子view
 */
- (UIView *)viewWithTag:(NSInteger)tag;

/**
 *  设置window的级别
 *
 *  @param aLevel window级别
 */
- (void)setPrivateWindowLevel:(NSInteger)aLevel;
@end
