//
//  VerticallyAlignedLabel.h
//  JusAuto
//
//  Created by ju on 2017/3/3.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {

}

@property (nonatomic, assign) VerticalAlignment alignment;

@end
