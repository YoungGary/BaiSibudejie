//
//  GYLoginViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/26.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYLoginViewController.h"
#import "GYLoginView.h"
#import "GYFastLoginView.h"
@interface GYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation GYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GYLoginView *loginView = [GYLoginView loginView];
    [self.loginView addSubview:loginView];
    GYLoginView *RegisiterView = [GYLoginView registerView];
    [self.loginView addSubview:RegisiterView];
    GYFastLoginView *fast = [GYFastLoginView fastLoginView];
    [self.bottomView addSubview:fast];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    GYLoginView *loginView = self.loginView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.loginView.gy_width *0.5, self.loginView.gy_height*0.5);
    GYLoginView *RegisiterView =self.loginView.subviews[1];
    RegisiterView.frame = CGRectMake( self.loginView.gy_width *0.5, 0,  self.loginView.gy_width *0.5, self.loginView.gy_height*0.5);
    GYFastLoginView *fast = self.bottomView.subviews.firstObject;
    fast.frame = self.bottomView.bounds;
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
 
    
}
- (IBAction)registerButoon:(UIButton *)sender {
    sender.selected = !sender.selected ;
    // 平移中间view
    _leadCons.constant = _leadCons.constant == 0? -self.loginView.gy_width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
