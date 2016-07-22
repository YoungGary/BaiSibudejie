//
//  GYADViewController.m
//  Budejie
//
//  Created by YOUNG on 16/7/23.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYADViewController.h"

@interface GYADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lanuchImage;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation GYADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImage];
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
