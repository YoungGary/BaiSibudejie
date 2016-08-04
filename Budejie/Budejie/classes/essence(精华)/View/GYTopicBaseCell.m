//
//  GYTopicBaseCell.m
//  Budejie
//
//  Created by YOUNG on 16/8/4.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYTopicBaseCell.h"

@implementation GYTopicBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //top and bottom
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //frame
}


-(void)setModel:(GYTopicModel *)model{
    _model =  model;
    //model
    
}











@end
