//
//  UIBarButtonItem+Extension.m
//  Budejie
//
//  Created by YOUNG on 16/7/22.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)



+ (UIBarButtonItem *)setupBarButtonItemWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highImage withTarget:(nullable id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *container = [[UIView alloc]initWithFrame:button.bounds];
    [container addSubview:button];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:container];
    return barButton;
}

+ (UIBarButtonItem *)setupBarButtonItemWithImage:(UIImage *)image withSelectedImage:(UIImage *)highImage withTarget:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *container = [[UIView alloc]initWithFrame:button.bounds];
    [container addSubview:button];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:container];
    return barButton;
}



@end
