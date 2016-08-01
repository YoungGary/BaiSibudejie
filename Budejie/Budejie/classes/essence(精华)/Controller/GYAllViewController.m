//
//  GYAllViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/31.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYAllViewController.h"

@interface GYAllViewController ()

@property(nonatomic,assign)NSInteger dataCount;

@property(nonatomic,weak)UILabel *label;

@property(nonatomic,weak)UIView  *footerView;

@property(nonatomic,assign,getter=isRefresh)BOOL refreshing;

@end

@implementation GYAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 10;
    self.view.backgroundColor = [UIColor redColor];

    self.tableView.contentInset = UIEdgeInsetsMake(64+44, 0, 49, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectTabbarButton) name:@"tabbardidselect" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectTitleButton) name:@"titleButtonSelected" object:nil];
    
    [self setupFooterView];
    
}

-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]init];
    self.footerView = footerView;
    footerView.frame = CGRectMake(0, 0, self.tableView.gy_width, 44);
    self.tableView.tableFooterView = footerView;
    
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
}

#pragma mark -- 重复点击titleBUTTON
- (void)didSelectTitleButton{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    NSLog(@"%@---reload",self.class);
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

#pragma mark -- scrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.tableView.contentSize.height == 0) return;
    if (self.isRefresh) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.tableFooterView.gy_height - self.tableView.gy_height;
    if (scrollView.contentOffset.y >= offsetY) {
        //进入刷新状态
        self.refreshing = YES;
        self.label.text = @"正在加载中..";
        self.label.backgroundColor = [UIColor cyanColor];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.dataCount += 5;
            [self.tableView reloadData];
            
            self.refreshing  = NO;
            self.label.text = @"上拉加载更多数据";
            self.label.textColor = [UIColor whiteColor];
            self.label.backgroundColor = [UIColor orangeColor];
            
        });
    }
}





-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
