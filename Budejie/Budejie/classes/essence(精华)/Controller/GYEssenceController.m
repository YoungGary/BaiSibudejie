//
//  GYEssenceController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYEssenceController.h"



@implementation GYEssenceController





-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNaviItem];
}

-(void)setupNaviItem{
    //left;
    UIBarButtonItem *left =  [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] withHighlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] withTarget:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem =left;
    //right
    UIBarButtonItem *right =[UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] withHighlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] withTarget:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = right;
    //title
    
    self.navigationItem.titleView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}



-(void)game{
    NSLog(@"game");
}














@end
