//
//  GYADViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/23.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYADViewController.h"
#import "AFNetWorking.h"
#import "GYADModel.h"
#import "MJExtension.h"
#import <UIImageView+WebCache.h>
#import "GYTabbarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
@interface GYADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lanuchImage;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,weak) UIImageView    *adView;
@property(nonatomic,strong)GYADModel *model;
@property(nonatomic,weak)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

@end

@implementation GYADViewController
//lazy method
-(UIImageView *)adView{
    if (nil == _adView) {
        UIImageView *image = [[UIImageView alloc]init];
        image.userInteractionEnabled = YES;
        [self.contentView addSubview:image];
        //tap
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transform)];
        [image addGestureRecognizer:tap];
        _adView = image;
    }
    return _adView;
}
//tap
-(void)transform{
    [[UIApplication sharedApplication ]openURL:[NSURL URLWithString:self.model.ori_curl]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImage];
    [self setupPicture];
   _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    
}
//timer
- (void)timeChange{
    static int i = 3;
    if (i == 0) {
        //跳转
        GYTabbarController *tab = [[GYTabbarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController =tab;
        //销毁
        [self.timer invalidate];
        
    }
    i--;
    NSString *title = [NSString stringWithFormat:@"跳过(%d)",i];
    [self.jumpButton setTitle:title forState:UIControlStateNormal];
}
//跳过
- (IBAction)ClickButtonJump:(id)sender {
    //跳转
    GYTabbarController *tab = [[GYTabbarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController =tab;
    //销毁
    [self.timer invalidate];
}
//网络加载数据
-(void)setupPicture{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *baseUrl = @"http://mobads.baidu.com/cpro/ui/mads.php";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"code2"] =code2;
   
   [manager GET: baseUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
       NSDictionary *dict = [responseObject[@"ad"] lastObject];
       GYADModel *model =[GYADModel mj_objectWithKeyValues:dict];
       self.model = model;
       //高度按比例拉伸
       CGFloat h =ScreenWidth/ model.w *model.h;
       self.adView.frame = CGRectMake(0, 0, ScreenWidth, h);
       
       [self.adView sd_setImageWithURL:[NSURL URLWithString:model.w_picurl]];
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error);
   }];
}



//设置图片
-(void)setupImage{
    if(iPhone6P){
        self.lanuchImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6){
        self.lanuchImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iPhone5){
        self.lanuchImage.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if(iPhone4){
        self.lanuchImage.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
