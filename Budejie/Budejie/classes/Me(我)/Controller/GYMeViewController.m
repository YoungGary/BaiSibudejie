//
//  GYMeViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/21.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYMeViewController.h"
#import "GYSettingViewController.h"
#import "GYCollectionViewCell.h"

static NSString *const identifier = @"cell";
@interface GYMeViewController()<UICollectionViewDataSource>


@end

@implementation GYMeViewController


-(void)viewDidLoad{
    [super viewDidLoad];
   
    [self setupNaviBar];
    [self setupCollectionView];
    //注册cell
    
    
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat margin = 1;
    CGFloat cols = 4;
    CGFloat width = (ScreenWidth- (cols-1)*margin)/cols;
    layout.itemSize = CGSizeMake(width, width );
    layout.minimumLineSpacing = margin  ;
    layout.minimumInteritemSpacing = margin;
    UICollectionView *collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 400) collectionViewLayout:layout];
    
    collect.dataSource =self;
    self.tableView.tableFooterView = collect;
    collect.backgroundColor =self.tableView.backgroundColor ;
    
    [collect registerNib:[UINib nibWithNibName:@"GYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}


#pragma mark ----data source collectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    
    return cell;
}















-(void)setupNaviBar{
    UIBarButtonItem *setting = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] withHighlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] withTarget:self action:@selector(setting)];
    UIBarButtonItem *night = [UIBarButtonItem setupBarButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] withSelectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] withTarget:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,night];
    self.navigationItem.title = @"我的";
}
  //跳转到设置
-(void)setting{
  
    GYSettingViewController *setting = [[GYSettingViewController alloc]init];
    setting.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:setting animated:YES];
    
}

-(void)night:(UIButton *)button{
    button.selected = !button.selected;
}



@end
