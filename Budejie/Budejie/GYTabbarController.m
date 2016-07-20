//
//  GYTabbarController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYTabbarController.h"
#import "GYEssenceController.h"
#import "GYNewViewController.h"
#import "GYPublishViewController.h"
#import "GYFriendViewController.h"
#import "GYMeViewController.h"
#import "GYNaviController.h"
#import "UIImage+Image.h"
@implementation GYTabbarController

+(void)load{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName ] = [UIColor blackColor];
    [[UITabBarItem appearanceWhenContainedIn:self, nil] setTitleTextAttributes:attr forState:UIControlStateSelected];
    //字体
    NSMutableDictionary *attrFont = [NSMutableDictionary dictionary];
    attrFont[NSFontAttributeName ] = [UIFont systemFontOfSize:13 ];
    [[UITabBarItem appearanceWhenContainedIn:self, nil] setTitleTextAttributes:attrFont forState:UIControlStateNormal];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self addChildVC];
}

-(void)addChildVC{
    GYEssenceController *essence = [[GYEssenceController alloc]init];
    [self addOneChildViewControllerWithVC:essence WithImageName:@"tabBar_essence_icon" WithSelectedImageName:@"tabBar_essence_click_icon" WithTitle:@"精华"];
    
    GYNewViewController *new = [[GYNewViewController alloc]init];
    [self addOneChildViewControllerWithVC:new WithImageName:@"tabBar_new_icon" WithSelectedImageName:@"tabBar_new_click_icon" WithTitle:@"新帖"];
    
    GYPublishViewController *publish = [[GYPublishViewController alloc]init];
    [self addOneChildViewControllerWithVC:publish WithImageName:@"tabBar_publish_icon" WithSelectedImageName:@"tabBar_publish_click_icon" WithTitle:@""];
    
    GYFriendViewController *friend = [[GYFriendViewController alloc]init];
   [self addOneChildViewControllerWithVC:friend WithImageName:@"tabBar_friendTrends_icon" WithSelectedImageName:@"tabBar_friendTrends_click_icon" WithTitle:@"关注"];
    
    GYMeViewController *me = [[GYMeViewController alloc]init];
    [self addOneChildViewControllerWithVC:me WithImageName:@"tabBar_me_icon" WithSelectedImageName:@"tabBar_me_click_icon" WithTitle:@"我"];
}

-(void)addOneChildViewControllerWithVC:(UIViewController *)vc WithImageName:(NSString*)imageName WithSelectedImageName:(NSString *)selName WithTitle:(NSString *)title{
    GYNaviController *nav = [[GYNaviController alloc]initWithRootViewController:vc];
    UIImage *image = [UIImage imageWithOriginalImageNamed:imageName];
    UIImage *selImage = [UIImage imageWithOriginalImageNamed:selName];
    nav.tabBarItem.title = title;
    nav.tabBarItem.selectedImage = selImage;
    nav.tabBarItem.image = image;
    
    [self addChildViewController:nav];
    
    
    
    
}
















@end
