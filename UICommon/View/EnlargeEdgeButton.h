//
//  EnlargeEdgeButton.h
//  
//
//  Created by mike
//
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface EnlargeEdgeButton : UIButton
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
