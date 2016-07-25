//
//  GYFriendViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYFriendViewController.h"
#import "GYLoginViewController.h"
@implementation GYFriendViewController



-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupNaviBar];
    
}


- (IBAction)didClickLoginButton:(id)sender {
    GYLoginViewController *login= [[GYLoginViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}


-(void)setupNaviBar{
    UIBarButtonItem *left = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] withHighlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] withTarget:self action:@selector(left)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.title = @"我的关注";
}
-(void)left{
    
}












@end
