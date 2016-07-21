//
//  GYMeViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYMeViewController.h"
#import "GYSettingViewController.h"
@implementation GYMeViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self setupNaviBar];
}




-(void)setupNaviBar{
    UIBarButtonItem *setting = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] withHighlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] withTarget:self action:@selector(setting)];
    UIBarButtonItem *night = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] withSelectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] withTarget:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,night];
    self.navigationItem.title = @"我的";
}
-(void)setting{
    //跳转到设置
    GYSettingViewController *setting = [[GYSettingViewController alloc]init];
    setting.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:setting animated:YES];
    
}

-(void)night:(UIButton *)button{
    button.selected = !button.selected;
}










@end
