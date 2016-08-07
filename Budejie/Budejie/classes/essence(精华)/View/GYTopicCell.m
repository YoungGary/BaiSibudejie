//
//  GYTopicCell.m
//  Budejie
//
//  Created by YOUNG on 16/8/4.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYTopicCell.h"
#import <UIImageView+WebCache.h>

#import "GYTopicModel.h"

#import "GYVoiceCellView.h"
#import "GYVideoCellView.h"
#import "GYPictureCellView.h"
@interface  GYTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *maintextLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *hotCommentLabel;

@property (weak, nonatomic) IBOutlet UIView *hotConmmentView;

@end
@implementation GYTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setModel:(GYTopicModel *)model{
    _model =  model;
    //model
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      
    }];
    self.profileImageView.layer.cornerRadius = 17.5;
    self.nameLabel.text = model.name;
    self.passtimeLabel.text = model.passtime;
    self.maintextLabel.text = model.text;
    
    // 底部按钮的文字
    [self setupButtonTitle:self.dingButton withInteger:model.ding withPlaceHolder:@"顶"];
    [self setupButtonTitle:self.caiButton withInteger:model.cai withPlaceHolder:@"踩"];
    [self setupButtonTitle:self.shareButton withInteger:model.repost withPlaceHolder:@"分享"];
    [self setupButtonTitle:self.commentButton withInteger:model.comment withPlaceHolder:@"评论"];
    //最热评论
    if(model.top_cmt.count){
        self.hotConmmentView.hidden = NO;
        NSDictionary *cmt = model.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) { // 语音评论
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.hotCommentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    
    }else{
        self.hotConmmentView.hidden = YES;
    }
    //声音 视频 图片 view
    if(model.type == TopicTypePicture){//图片
        [self.contentView addSubview:[GYPictureCellView loadNibFromSelf]];
    }else if (model.type == TopicTypeVoice){//音频
        [self.contentView addSubview:[GYVoiceCellView loadNibFromSelf]];
    }else if (model.type == TopicTypeVideo){//视频
        [self.contentView addSubview:[GYVideoCellView loadNibFromSelf]];
    }
    
}

-(void)setupButtonTitle:(UIButton*)button withInteger:(NSInteger)number withPlaceHolder:(NSString*)placeHolder{
    if (number > 10000) {
        NSString *title = [NSString stringWithFormat:@"%.1f万",number/10000.0];
        [button setTitle:title forState:UIControlStateNormal];
    }else if(number > 0){
         NSString *title = [NSString stringWithFormat:@"%zd",number];
        [button setTitle:title forState:UIControlStateNormal];
    }else{
        [button setTitle:placeHolder forState:UIControlStateNormal];
    }
}


-(void) setFrame:(CGRect)frame{
    frame.size.height-=10;
    [super setFrame:frame];
}








@end
