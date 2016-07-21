//
//  GYMeViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYMeViewController.h"

@implementation GYMeViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self setupNaviBar];
}




-(void)setupNaviBar{
    UIBarButtonItem *setting = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] withHighlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] withTarget:self action:@selector(right)];
    UIBarButtonItem *night = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] withSelectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] withTarget:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,night];
    self.navigationItem.title = @"我的";
}
-(void)right{
    
}

-(void)night:(UIButton *)button{
    button.selected = !button.selected;
}

@end
