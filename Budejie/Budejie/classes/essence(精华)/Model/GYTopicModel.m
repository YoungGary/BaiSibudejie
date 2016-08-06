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
         CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(ScreenWidth-20, MAXFLOAT)];
        _cellHeight += size.height;//text height
        _cellHeight += 20;//margin
        _cellHeight += 35;//bottom
    
    
    return _cellHeight;
}

@end
