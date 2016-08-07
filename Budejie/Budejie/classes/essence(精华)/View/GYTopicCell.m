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

//中间3种图片 懒加载 所以生成属性
@property(nonatomic,weak)GYPictureCellView *pictureView;

@property(nonatomic,weak)GYVoiceCellView *voiceView;

@property(nonatomic,weak)GYVideoCellView *videoView;


@end
@implementation GYTopicCell
#pragma mark -- 懒加载中间图片
-(GYPictureCellView *)pictureView{
    if (nil == _pictureView) {
        _pictureView = [GYPictureCellView loadNibFromSelf];
    }
    return _pictureView;
}

-(GYVoiceCellView *)voiceView{
    if (nil == _voiceView) {
        _voiceView = [GYVoiceCellView loadNibFromSelf];
    }
    return _voiceView;
}

-(GYVideoCellView *)videoView{
    if (nil == _videoView) {
        _videoView = [GYVideoCellView loadNibFromSelf];
    }
    return _videoView;
}

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
        [self.contentView addSubview:self.pictureView];
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (model.type == TopicTypeVoice){//音频
        [self.contentView addSubview:self.voiceView];
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        //设置model
        self.voiceView.model = model;
        
    }else if (model.type == TopicTypeVideo){//视频
        [self.contentView addSubview:self.videoView];
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
    }else if (model.type == TopicTypeWord){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
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

//计算中间内容的rect
-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.model.type == TopicTypePicture){//图片
        self.pictureView.frame = self.model.middleFrame;
       
    }else if (self.model.type == TopicTypeVoice){//音频
        self.voiceView.frame = self.model.middleFrame;
        
    }else if (self.model.type == TopicTypeVideo){//视频
        self.videoView.frame = self.model.middleFrame   ;
    }
}






@end
