//
//  UIImage+Image.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)


+(UIImage *)imageWithOriginalImageNamed:(NSString*)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



@end
