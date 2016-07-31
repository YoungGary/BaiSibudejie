//
//  GYEssenceController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYEssenceController.h"

#import "GYAllViewController.h"
#import "GYVideoViewController.h"
#import "GYVoiceViewController.h"
#import "GYPictureViewController.h"
#import "GYWordViewController.h"
@interface GYEssenceController()

@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UIButton *selectedButton;

@property(nonatomic,strong)UIView *underline;

@end


@implementation GYEssenceController


-(void)viewDidLoad{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupChildVC];
    
    [self setupNaviItem];
    
    [self setupScrollView];
    
    [self setupTitleView];
    
  
}

-(void)setupChildVC{
    
    [self addChildViewController:[[GYAllViewController alloc]init]];
    [self addChildViewController:[[GYVideoViewController alloc]init]];
    [self addChildViewController:[[GYVoiceViewController alloc]init]];
    [self addChildViewController:[[GYPictureViewController alloc]init]];
    [self addChildViewController:[[GYWordViewController alloc]init]];

}

- (void)setupTitleView{
    UIView *titleView = [[UIView alloc]init];
    [self.view addSubview:titleView];
    titleView.frame = CGRectMake(0, 64, ScreenWidth, 44);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.titleView = titleView;
    
    [self setupButtons];
    [self setupUnderLine];
    
}

-(void)setupUnderLine{
    UIButton *firstButton = self.titleView.subviews.firstObject;
    
    UIView *underline = [[UIView alloc]init];
    self.underline = underline;
    underline.gy_height = 2;
    underline.gy_y = self.titleView.gy_height - underline.gy_height;
    //下划线长度
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSFontAttributeName] = firstButton.titleLabel.font;
//    self.underline.gy_width = [[firstButton currentTitle] sizeWithAttributes:attr].width;
    //下划线长度第二中计算方法
//    self.underline.gy_width = firstButton.titleLabel.gy_width;
//    
//    self.underline.gy_centerX = firstButton.gy_centerX;
    
    
    [self.titleView addSubview:underline];
    underline .backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    //不写这一句 出不来下划线
    [firstButton.titleLabel sizeToFit];
    [self buttonClick:firstButton];
}


-(void)setupButtons{
    NSInteger count = 5;
    CGFloat buttonWidth = ScreenWidth/count;
    NSArray *title = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat buttonHeight = 44;
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleView addSubview:button];
        
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setTitle:title[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal ];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)buttonClick:(UIButton *)button{
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
  
    [UIView animateWithDuration:0.25 animations:^{
        //underline 的width 和文字宽度一致
//        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//        attr[NSFontAttributeName] = button.titleLabel.font;
//        self.underline.gy_width = [[button currentTitle] sizeWithAttributes:attr].width;
        self.underline.gy_width = button.titleLabel.gy_width;
        self.underline.gy_centerX = button.gy_centerX;
        
    }];
}
#pragma mark -- scrollview

-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator  = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    CGFloat width = scrollView.gy_width;
    CGFloat height = scrollView.gy_height;
    CGFloat y = 0;
    for (int i = 0; i < 5; i++) {
        UIView *childView = self.childViewControllers[i].view;
        childView.frame = CGRectMake(i * width, y, width, height);
        [scrollView addSubview:childView];
    }
    scrollView.contentSize = CGSizeMake(5 *scrollView.gy_width, 0);
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
    function;
}

@end
