//
//  GYVideoCellView.m
//  Budejie
//
//  Created by YOUNG on 16/8/7.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYVideoCellView.h"
#import <AFNetWorking.h>
#import <UIImageView+WebCache.h>
#import "GYTopicModel.h"
@interface GYVideoCellView()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end
@implementation GYVideoCellView

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}


-(void)setModel:(GYTopicModel *)model{
    _model = model;
    
    AFNetworkReachabilityManager *manager =  [AFNetworkReachabilityManager sharedManager];
    
    UIImage *bigImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.image1];//从缓存路径中取下载好的大图
    
    if (bigImage) {//如果有大图 则直接赋值
        self.backgroundImage.image = bigImage;
    }else{//如果没有
        if (manager.isReachableViaWiFi) {//WiFi状态则下载大图1
            [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image1]];
        }else if (manager.isReachableViaWWAN){//流量下载小图
            [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image0]];
        }else{//没有可用网络
            UIImage *small = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.image0];//从缓存路径中取下载好的小1图
            if (small) {//如果有小图 则赋值小图
                self.backgroundImage.image = small;
            }else{//没有小图 则为空
                self.backgroundImage.image = nil;
            }
        }
    }
    
    if (model.playcount > 10000) {
        NSString *count = [NSString stringWithFormat:@"%.1f万次播放",model.playcount/10000.0];
        self.playCountLabel.text = count;
    }else{
        self.playCountLabel.text =[NSString stringWithFormat:@"%zd次播放",model.playcount];
    }
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",model.videotime/60,model.videotime%60];
    
    
    
    
}














@end
