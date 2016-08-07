//
//  GYVoiceCellView.m
//  Budejie
//
//  Created by YOUNG on 16/8/7.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYVoiceCellView.h"
#import "GYTopicModel.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
@interface GYVoiceCellView()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end
@implementation GYVoiceCellView

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setModel:(GYTopicModel *)model{
    _model = model;
    //根据网络状态加载图片
    
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
    
  //  [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    
    
    
    
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",model.voicetime/60,model.voicetime%60];
    if (model.playcount > 10000) {
        self.playCountLabel .text = [NSString stringWithFormat:@"%.1f万次播放",model.playcount/10000.0];
    }else{
        self.playCountLabel .text = [NSString stringWithFormat:@"%zd次播放",model.playcount];
    }
    
}















@end
