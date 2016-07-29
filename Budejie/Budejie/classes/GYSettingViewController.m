//
//  GYSettingViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/22.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYSettingViewController.h"
#import <SDWebImage/SDImageCache.h>
static NSString * const identifier = @"cell";
@interface GYSettingViewController ()

@end

@implementation GYSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.tableFooterView = [[UIView alloc ]init];
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   NSInteger totalSize =  [self getCacheSize];//自己算的cache
    //sdwebimage帮我们计算缓存
   // NSInteger size = [SDImageCache sharedImageCache].getSize;
   // NSLog(@"sdwebIMage=%ld",size);
    NSString *baseStr  = @"清除缓存";
    
    if (totalSize>1000 *1000) {
        CGFloat size = totalSize/1000/1000;
        baseStr = [NSString stringWithFormat:@"%@(%.1fMB)",baseStr,size];
    }else if(totalSize>1000){
        CGFloat size = totalSize/1000;
        baseStr = [NSString stringWithFormat:@"%@(%.1fKB)",baseStr,size];
    }else if(totalSize >1){
         baseStr = [NSString stringWithFormat:@"%@(%.ldB)",baseStr,totalSize];
    }
     cell.textLabel.text = baseStr;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    //点击cell删除缓存
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *file = [manager contentsOfDirectoryAtPath:cache error:nil];
    for (NSString *filePath in file) {
        NSString *fileTotalPath = [cache stringByAppendingPathComponent:filePath];
        [manager removeItemAtPath:fileTotalPath error:nil];
        
    }
    [self.tableView reloadData];
}


-(NSInteger)getCacheSize{//自己算cache有多少
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *defaultPath = [cache stringByAppendingPathComponent:@"default"];
    
    NSArray *filePath = [manager subpathsAtPath:defaultPath];
    //NSLog(@"%@",filePath);
    NSInteger totalSize = 0;
    for (NSString *path in filePath) {
        NSString *totalPath = [defaultPath stringByAppendingPathComponent:path];
        //过滤.DS
        if ([totalPath containsString:@".DS"]) {
            continue;
        }
        //判断是否是文件夹
        BOOL isDirectory;
        BOOL exist = [manager fileExistsAtPath:totalPath isDirectory:&isDirectory];
        if (!exist || isDirectory) {
            continue;
        }
        
        
        NSDictionary *dict = [manager attributesOfItemAtPath:totalPath error:nil];
        totalSize += [dict fileSize];
        
    }
    return totalSize;
}















@end
