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
@interface GYEssenceController()<UIScrollViewDelegate>

@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UIButton *selectedButton;

@property(nonatomic,strong)UIView *underline;

@property(nonatomic,strong)UIScrollView *scrollView;

@end


@implementation GYEssenceController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildVC];
    
    [self setupNaviItem];
    
    [self setupScrollView];
    
    [self setupTitleView];
    //加载第一个view
    NSInteger index = 0;
    CGFloat width = self.scrollView.gy_width;
    CGFloat height = self.scrollView.gy_height;
    UIView *childView = self.childViewControllers[index].view;
    childView.frame = CGRectMake(index * width, 0, width, height);
    [self.scrollView addSubview:childView];
    
    
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
        button.tag = i;
        
        [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

#pragma mark -- cilck button
-(void)buttonClick:(UIButton *)button{
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    NSInteger index = button.tag;
    CGFloat width = self.scrollView.gy_width;
    CGFloat height = self.scrollView.gy_height;
  
    [UIView animateWithDuration:0.25 animations:^{
        //underline 的width 和文字宽度一致
//        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//        attr[NSFontAttributeName] = button.titleLabel.font;
//        self.underline.gy_width = [[button currentTitle] sizeWithAttributes:attr].width;
        self.underline.gy_width = button.titleLabel.gy_width;
        self.underline.gy_centerX = button.gy_centerX;
        
        //点击按钮 scrollView 滑动到指定的页面
        CGFloat offsetX = ScreenWidth *button.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        
    } completion:^(BOOL finished) {//懒加载view
        UIView *childView = self.childViewControllers[index].view;
        childView.frame = CGRectMake(index * width, 0, width, height);
        [self.scrollView addSubview:childView];
        
    }];
    //scroll to top
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        UIViewController *childVC = self.childViewControllers[i];
        if (!childVC.isViewLoaded) continue;
         UIScrollView *scroll = (UIScrollView *)childVC.view;
        if (![scroll isKindOfClass:[UIScrollView class]]) continue;
        scroll.scrollsToTop = (i == index);
    
    }
}
#pragma mark -- scrollview set up

-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator  = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
//    
//    CGFloat width = scrollView.gy_width;
//    CGFloat height = scrollView.gy_height;
//    CGFloat y = 0;
//    for (int i = 0; i < 5; i++) {//子控制器的view加到scrollView上
//        UIView *childView = self.childViewControllers[i].view;
//        childView.frame = CGRectMake(i * width, y, width, height);
//        [scrollView addSubview:childView];
//    }
    scrollView.contentSize = CGSizeMake(5 *scrollView.gy_width, 0);
}

#pragma mark -- scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger  index = scrollView.contentOffset.x/ScreenWidth;
    UIButton *button = self.titleView.subviews[index];
    [self buttonClick:button];
    
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
