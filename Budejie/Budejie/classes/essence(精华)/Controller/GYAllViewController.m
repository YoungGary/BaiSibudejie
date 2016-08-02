//
//  GYAllViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/31.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYAllViewController.h"

@interface GYAllViewController ()
//下拉刷新
@property(nonatomic,weak)UIView *headerView;

@property(nonatomic,weak)UILabel *topLabel;

@property(nonatomic,weak)UILabel *refreshLabel;

@property(nonatomic,assign,getter=isRefreshdown)BOOL refreshingdown;
//上拉刷新
@property(nonatomic,assign)NSInteger dataCount;

@property(nonatomic,weak)UILabel *label;

@property(nonatomic,weak)UIView  *footerView;

@property(nonatomic,assign,getter=isRefreshup)BOOL refreshingUp;

@end

@implementation GYAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 20;
    self.view.backgroundColor = [UIColor redColor];

    self.tableView.contentInset = UIEdgeInsetsMake(64+44, 0, 49, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectTabbarButton) name:@"tabbardidselect" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectTitleButton) name:@"titleButtonSelected" object:nil];
    
    [self setupHeadRefreash];
    [self setupFooterView];
    
}
#pragma mark -- 下拉刷新  创建headerView
-(void)setupHeadRefreash{
    UIView *headerView = [[UIView alloc]init];
    self.headerView = headerView;
    headerView.frame = CGRectMake(0, 0, self.tableView.gy_width, 44);
    self.tableView.tableHeaderView = headerView;
    
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"广告";
    topLabel.textColor = [UIColor whiteColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.backgroundColor = [UIColor blackColor];
    topLabel.frame = self.headerView.bounds;
    self.topLabel = topLabel;
    [headerView addSubview:topLabel];
    
    //创建下拉刷新控件
    UILabel *refreshLabel = [[UILabel alloc]init];
    self.refreshLabel =  refreshLabel;
    refreshLabel.backgroundColor = [UIColor cyanColor];
    refreshLabel.text = @"下拉可以刷新";
    refreshLabel.textColor = [UIColor whiteColor];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.frame = CGRectMake(0, -50, self.tableView.gy_width, 50);
    [self.tableView addSubview:refreshLabel];
}


#pragma mark -- 上拉刷新 创建 footerView
-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]init];
    self.footerView = footerView;
    footerView.frame = CGRectMake(0, 0, self.tableView.gy_width, 44);
    self.tableView.tableFooterView = footerView;
    
    [self HeaderBeginRefresh];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"上拉加载更多数据";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    label.frame = footerView.bounds;
    self.label = label;
    [footerView addSubview:label];
    
}
#pragma mark -- 重复点击tabbar

- (void)didSelectTabbarButton{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    NSLog(@"%@---reload",self.class);
    [self HeaderBeginRefresh];
}

#pragma mark -- 重复点击titleBUTTON
- (void)didSelectTitleButton{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    NSLog(@"%@---reload",self.class);
    [self HeaderBeginRefresh];
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.tableFooterView.hidden = (self.dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *string = [NSString stringWithFormat: @"%@=====%ld",self.class,indexPath.row ];
    cell.textLabel.text = string;
    
    return cell;
}

#pragma mark -- scrollView delegate 监听offset
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self.isRefreshdown) return;
    
     CGFloat offsetY = self.tableView.contentInset.top + self.refreshLabel.gy_height;
    if (self.tableView.contentOffset.y < -offsetY) {
        [self HeaderBeginRefresh];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self dealWithHeaderView];
    
    [self dealwithFooterView];
}
#pragma mark --   处理下拉刷新
- (void)dealWithHeaderView{
    
    if(self.isRefreshdown) return;
    if (self.tableView.contentSize.height == 0) return;
    CGFloat offsetY = self.tableView.contentInset.top + self.refreshLabel.gy_height;
    if (self.tableView.contentOffset.y <= -offsetY) {
        self.refreshLabel.text = @"松开立即刷新";
        self.refreshLabel.backgroundColor = [UIColor orangeColor];
    }else{
        self.refreshLabel.text = @"下拉可以刷新";
        self.refreshLabel.backgroundColor = [UIColor cyanColor];
    }
}
#pragma mark --  处理上拉刷新

-(void)dealwithFooterView{
    if (self.tableView.contentSize.height == 0) return;
    if (self.isRefreshup) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.tableFooterView.gy_height - self.tableView.gy_height;
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        [self FooterBeginRefresh];
    }
}

- (void)HeaderBeginRefresh{
    if (self.isRefreshdown) return;
    self.refreshingdown = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.refreshLabel.backgroundColor = [UIColor blueColor];
        self.refreshLabel.text = @"刷新中...";
        self.refreshLabel.textColor = [UIColor whiteColor];
        self.refreshLabel.textAlignment = NSTextAlignmentCenter;
        
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.refreshLabel.gy_height;
        self.tableView.contentInset = inset;
        //偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - inset.top);
    }];
    NSLog(@"发送请求---下拉");
    [self HeaderEndRefresh];
}

-(void)HeaderEndRefresh{
    //向服务器请求数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.refreshLabel.backgroundColor = [UIColor cyanColor];
            self.refreshLabel.text = @"下拉可以刷新";
            self.refreshLabel.textColor = [UIColor whiteColor];
            self.refreshLabel.textAlignment = NSTextAlignmentCenter;
            
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top -= self.refreshLabel.gy_height;
            self.tableView.contentInset = inset;
            
            self.refreshingdown = NO;
            
        }];
        
    });
}

- (void)FooterBeginRefresh{
    //进入刷新状态
    self.refreshingUp = YES;
    self.label.text = @"正在加载中..";
    self.label.backgroundColor = [UIColor cyanColor];
    
    [self FooterEndRefresh];
    
}

- (void)FooterEndRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.dataCount += 5;
        [self.tableView reloadData];
        
        self.refreshingUp  = NO;
        self.label.text = @"上拉加载更多数据";
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor orangeColor];
        
    });
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
