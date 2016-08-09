//
//  HFRoundedImageView.m
//  FoldingBicycle
//
//  Created by YZJ on 16/3/9.
//  Copyright © 2016年 YZJ. All rights reserved.
//

#import "HFRoundedImageView.h"

@implementation HFRoundedImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self draw];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self draw];
    }
    return self;
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (![_borderColor isEqual:borderColor]) {
        _borderColor = borderColor;
        [self draw];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        [self draw];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius != cornerRadius) {
        _cornerRadius = cornerRadius;
        [self draw];
    }
}

- (void)draw {
    CALayer *layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.cornerRadius];
    if (self.borderWidth < 0) {
        self.borderWidth = 3.0;
    }
    [layer setBorderWidth:self.borderWidth];
    if (self.borderColor == nil) {
        self.borderColor = [UIColor lightGrayColor];
    }
    [layer setBorderColor:[self.borderColor CGColor]];
}


@end
