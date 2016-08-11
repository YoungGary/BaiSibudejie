//
//  GYSeeBigImageViewController.m
//  Budejie
//
//  Created by YOUNG on 16/8/11.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYSeeBigImageViewController.h"
#import "GYTopicModel.h"

#import <UIImageView+WebCache.h>
@interface GYSeeBigImageViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation GYSeeBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [scrollView addGestureRecognizer:tap];
   // scrollView.frame = self.view.bounds;
   // scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.saveButton.enabled = YES;
    }];
    
    imageView.userInteractionEnabled = YES;
    imageView.gy_x = 0;
    imageView.gy_width = scrollView.gy_width;
    imageView.gy_height  = imageView.gy_width * self.model.height/self.model.width;
    if (self.model.height > ScreenHeight) {//大图
        imageView.gy_y = 0;
        //imageView.gy_height = self.model. height;
        scrollView.contentSize = CGSizeMake(0, imageView.gy_height);
    }else{//小图
        imageView.gy_centerY = scrollView.gy_height/2;
    }
    [scrollView addSubview:imageView ];
    self.imageView = imageView;
    //图片缩放
    CGFloat maxScale = self.model.height/imageView.gy_height;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

-(void)dismiss{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sava:(id)sender {//save to album
    
}


#pragma mark -- UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
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
