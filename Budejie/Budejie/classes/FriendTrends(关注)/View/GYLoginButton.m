//
//  GYLoginButton.m
//  Budejie
//
//  Created by YOUNG on 16/7/27
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYLoginButton.h"

@implementation GYLoginButton


-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.gy_y = 0;
    CGPoint imagecenter =  self.imageView.center;
    imagecenter.x = self.gy_width * 0.5;
    self.imageView.center = imagecenter;
    
    self.titleLabel.gy_y =self.gy_height - self.titleLabel.gy_height;
    CGPoint labelCenter =  self.titleLabel.center;
    labelCenter.x = self.gy_width * 0.5;
    self.titleLabel.center = labelCenter;
    [self.titleLabel sizeToFit];
    
}

@end
