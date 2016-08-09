//
//  HFRoundedImageView.h
//  FoldingBicycle
//
//  Created by YZJ on 16/3/9.
//  Copyright © 2016年 YZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface HFRoundedImageView : UIImageView

@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;


@end
