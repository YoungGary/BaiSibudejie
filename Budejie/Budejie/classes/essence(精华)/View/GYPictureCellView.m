//
//  GYPictureCellView.m
//  Budejie
//
//  Created by YOUNG on 16/8/7.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYPictureCellView.h"
#import "GYSeeBigImageViewController.h"

#import <AFNetWorking.h>
#import <UIImageView+WebCache.h>
#import "GYTopicModel.h"
@interface GYPictureCellView()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;

@end
@implementation GYPictureCellView

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.backgroundImage.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigPictures)];
    [self.backgroundImage addGestureRecognizer:tap];
    
}

- (void)seeBigPictures{
    GYSeeBigImageViewController *big = [[GYSeeBigImageViewController alloc]init];
    big.model = self.model;
    [self.window.rootViewController presentViewController:big animated:YES completion:nil];
}



-(void)setModel:(GYTopicModel *)model{
    _model=  model;
    
    AFNetworkReachabilityManager *manager =  [AFNetworkReachabilityManager sharedManager];
    
    UIImage *bigImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.image1];//从缓存路径中取下载好的大图
    
    if (bigImage) {//如果有大图 则直接赋值
        //self.backgroundImage.image = bigImage;
        [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    }else{//如果没有
        if (manager.isReachableViaWiFi) {//WiFi状态则下载大图1
            [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image1]];
        }else if (manager.isReachableViaWWAN){//流量下载小图
            [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image0]];
        }else{//没有可用网络
            UIImage *small = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.image0];//从缓存路径中取下载好的小1图
            if (small) {//如果有小图 则赋值小图
               // self.backgroundImage.image = small;
              [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image0]];
            }else{//没有小图 则为空
                self.backgroundImage.image = nil;
            }
        }
    }
    
    //gif是否显示
    self.gifView.hidden = !model.is_gif;
//    if([model.image1.pathExtension.lowercaseString isEqualToString:@"gif"]){
//        self.gifView.hidden = NO;
//    }else{
//        self.gifView.hidden = YES;
//    }
    //超长大图
    if (model.isBigPicture) {//是大图
        self.seeBigPicture.hidden = NO;
        self.backgroundImage.contentMode = UIViewContentModeTop;
        self.backgroundImage.clipsToBounds = YES;
        //处理sdwebimage显示的大图
        if(self.backgroundImage){
            CGFloat imageW = model.middleFrame.size.width;
            CGFloat imageh = imageW *model.height/model.width;
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageh));
            [self.backgroundImage.image drawInRect:CGRectMake(0, 0, imageW, imageh)];
            self.backgroundImage.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }else{
        self.seeBigPicture.hidden = YES;
        self.backgroundImage.contentMode = UIViewContentModeScaleToFill;
        self.backgroundImage.clipsToBounds = NO;
    }
    
    
}



















@end
