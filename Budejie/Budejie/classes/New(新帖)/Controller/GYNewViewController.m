//
//  GYNewViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYNewViewController.h"
#import "GYSubTagViewController.h"
@implementation GYNewViewController



-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNaviBar];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)setupNaviBar{
    UIBarButtonItem *left = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] withHighlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] withTarget:self action:@selector(left)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

-(void)left{
    GYSubTagViewController *tag = [[GYSubTagViewController alloc]init];
    tag.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tag animated:YES];
}














@end
