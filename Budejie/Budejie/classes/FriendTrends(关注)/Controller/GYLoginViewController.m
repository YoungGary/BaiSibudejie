//
//  GYLoginViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/26.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYLoginViewController.h"

@interface GYLoginViewController ()

@end

@implementation GYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerButoon:(UIButton *)sender {
    sender.selected = !sender.selected  ;
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
