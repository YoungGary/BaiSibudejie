//
//  GYTopicModel.h
//  Budejie
//
//  Created by YOUNG on 16/8/2.
//  Copyright © 2016年 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYTopicModel : NSObject

typedef NS_ENUM (NSInteger,TopicCellType){
    /** 全部 */
    TopicTypeAll = 1,
    /** 图片 */
    TopicTypePicture = 10,
    /** 段子 */
    TopicTypeWord = 29,
    /** 声音 */
    TopicTypeVoice = 31,
    /** 视频 */
    TopicTypeVideo = 41
};

@property(nonatomic,strong)NSString *maxtime;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;




@property(nonatomic,assign)CGFloat cellHeight;

@end
