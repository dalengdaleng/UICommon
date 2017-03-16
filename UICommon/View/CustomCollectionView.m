//
//  CustomCollectionView.m
//  
//
//  Created by Mike.
//
//

#import "CustomCollectionView.h"

@implementation CustomCollectionView

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize]))
    {
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicContentSize = self.contentSize;
    intrinsicContentSize.width = self.frame.size.width;
    
    return intrinsicContentSize;
}
//- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
//    
//}

@end
