//
//  UIView+Frame.m
//  Budejie
//
//  Created by YOUNG on 16/7/22.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)


-(void)setGy_height:(CGFloat)gy_height{
    CGRect rect = self.frame;
    rect.size.height = gy_height;
    self.frame = rect;
}

-(CGFloat)gy_height{
    return self.frame.size.height;
}

-(void)setGy_width:(CGFloat)gy_width{
    CGRect rect = self.frame;
    rect.size.width = gy_width;
    self.frame = rect;
}

-(CGFloat)gy_width{
    return self.frame.size.width;
}


-(void)setGy_x:(CGFloat)gy_x{
    CGRect rect = self.frame;
    rect.origin.x = gy_x;
    self.frame = rect;
}

-(CGFloat)gy_x{
    return self.frame.origin.x  ;
}


-(void)setGy_y:(CGFloat)gy_y{
    CGRect rect = self.frame;
    rect.origin.y = gy_y;
    self.frame = rect;
}

-(CGFloat)gy_y{
    return self.frame.origin.y;
}




@end
