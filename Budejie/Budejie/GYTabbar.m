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

@property(nonatomic,strong)UIControl *selectedButton;


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
    for (UIControl *tabbar in self.subviews) {
        if ([tabbar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            /* 默认第一个为选中的按钮 */
            if (i == 0 && self.selectedButton == nil) {
                self.selectedButton = tabbar;
            }
            
            if (i == 2) {
                i = i+1;
            }
            itemX = i*itemWidth;
            tabbar.frame = CGRectMake(itemX, 0, itemWidth, itemHeight);
            i++;
            
            //add target
            [tabbar addTarget:self action:@selector(clickTabbar:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
      
        
    }
    self.addButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
}

- (void)clickTabbar:(UIControl *)tabbar{
    if (self.selectedButton == tabbar) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tabbardidselect" object:nil];
    }
    self.selectedButton = tabbar;
}












@end
