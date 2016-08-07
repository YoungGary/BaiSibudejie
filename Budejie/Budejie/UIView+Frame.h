//
//  UIView+Frame.h
//  Budejie
//
//  Created by YOUNG on 16/7/22.
//  Copyright © 2016年 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat gy_width;

@property CGFloat gy_height;

@property CGFloat gy_x;

@property CGFloat gy_y;

@property CGFloat gy_centerX;

@property CGFloat gy_centerY;


+(instancetype)loadNibFromSelf;

@end
