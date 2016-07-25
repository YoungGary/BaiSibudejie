//
//  GYSubTagViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/24.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYSubTagViewController.h"
#import "GYSubTagModel.h"
#import "GYTagTableViewCell.h"

#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD-0.8.1/SVProgressHUD.h>

static NSString *const identifier= @"cell";

@interface GYSubTagViewController ()
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation GYSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromInternet];
    //register cell from xib
    [self.tableView registerNib:[UINib nibWithNibName:@"GYTagTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.title = @"推荐标签";
   // self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:1];
    [SVProgressHUD showWithStatus:@"正在加载中"];
    
}

-(void)loadDataFromInternet{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *baseUrl = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"]=@"tag_recommend";
    dict[@"action"]=@"sub";
    dict[@"c"]=@"topic";
    [manager GET:baseUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        [SVProgressHUD dismiss];
       // NSLog(@"%@",responseObject);
      _dataArray =   [GYSubTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GYTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    GYSubTagModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
