//
//  GYTabbar.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYTabbar.h"
@interface GYTabbar()

@property(nonatomic,weak)UIButton *addButton;

@end

@implementation GYTabbar

-(UIButton *)addButton{
    if (nil == _addButton) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _addButton = btn;
    }
    return _addButton;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.items.count+1;
    CGFloat itemWidth = self.bounds.size.width/count;
    CGFloat itemHeight = self.bounds.size.height;
    CGFloat itemX = 0;
    int i = 0;
    for (UIView *tabbar in self.subviews) {
        if ([tabbar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i = i+1;
            }
            itemX = i*itemWidth;
            tabbar.frame = CGRectMake(itemX, 0, itemWidth, itemHeight);
            i++;
        }
    }
    self.addButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
}




@end
