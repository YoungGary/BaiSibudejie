//
//  UIBarButtonItem+Extension.h
//  Budejie
//
//  Created by YOUNG on 16/7/22.
//  Copyright © 2016年 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


+ (UIBarButtonItem *)setupBarButtonItemWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highImage withTarget:(id)target action:(SEL)action;


+ (UIBarButtonItem *)setupBarButtonItemWithImage:(UIImage *)image withSelectedImage:(UIImage *)highImage withTarget:(id)target action:(SEL)action;

@end
