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
#import "GYMeModel.h"
#import "GYCollectionViewCell.h"

#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>

#import <SafariServices/SafariServices.h>
static CGFloat  const margin = 1;
static NSInteger const cols = 4;
#define  width (ScreenWidth- (cols-1)*margin)/cols
static NSString *const identifier = @"cell";
@interface GYMeViewController()<UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,strong)UICollectionView *collect;
@end

@implementation GYMeViewController


-(void)viewDidLoad{
    [super viewDidLoad];
   
    [self setupNaviBar];
    [self setupCollectionView];
    [self loadDataFromInternet];
    //处理分组样式cell间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}


-(void)loadDataFromInternet{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *baseurl = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"square";
    param[@"c"] =@"topic";
    [manager GET:baseurl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // [responseObject writeToFile:@"/Users/young/Desktop/square.plist" atomically:YES];
        NSArray *arr = responseObject[@"square_list"];
       _items = [GYMeModel mj_objectArrayWithKeyValuesArray:arr];
        [self resolveModel];
        //刷新列表
        [self.collect reloadData];
        //collectionView height
        NSInteger count = self.items.count;
        NSInteger rows = (count -1)/cols +1 ;
        self.collect.gy_height = rows *width;
        //
        self.tableView.tableFooterView = self.collect;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)resolveModel{
    NSInteger count = self.items.count;
    
    NSInteger extra = cols- count%cols;
    for (int i = 0; i < extra; i++) {
        GYMeModel *item = [[GYMeModel alloc]init];
        [self.items addObject:item];
    }
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(width, width );
    layout.minimumLineSpacing = margin  ;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 400) collectionViewLayout:layout];
    self.collect = collect ;
    self.collect.scrollEnabled  = NO;
    collect.dataSource =self;
    collect.delegate = self;
    
    self.tableView.tableFooterView = collect;
    collect.backgroundColor =self.tableView.backgroundColor;
    
    [collect registerNib:[UINib nibWithNibName:@"GYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}


#pragma mark ----data source collectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    GYMeModel *item = self.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

#pragma mark--- delegate collectionView


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GYMeModel *item = self.items[indexPath.row];
    
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    SFSafariViewController *safari = [[SFSafariViewController alloc ]initWithURL:url];
    [self presentViewController:safari animated:YES completion:nil];
}


#pragma mark -- SFsafariViewController delegate

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    [self.navigationController popViewControllerAnimated:YES];
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
