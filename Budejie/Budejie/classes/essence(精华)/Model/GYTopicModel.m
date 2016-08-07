//
//  GYTopicModel.m
//  Budejie
//
//  Created by YOUNG on 16/8/2.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYTopicModel.h"

@implementation GYTopicModel


-(CGFloat)cellHeight{
    
    if (_cellHeight) {
        return _cellHeight;
    }
    _cellHeight += 55;//top
//         CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(ScreenWidth-20, MAXFLOAT)];
//        _cellHeight += size.height;
         //text height
    _cellHeight += [self.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += 10;//margin
        //最热评论的高度
    if(self.top_cmt.count){
       //标题高度
        _cellHeight += 21;
        //内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [cmtText boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    }
    
    
    _cellHeight += 10;//margin
    _cellHeight += 35;//bottom
    
    
    return _cellHeight;
}

@end
