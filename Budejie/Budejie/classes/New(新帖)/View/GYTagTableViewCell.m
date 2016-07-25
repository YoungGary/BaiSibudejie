//
//  GYTagTableViewCell.m
//  Budejie
//
//  Created by YOUNG on 16/7/24.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYTagTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GYSubTagModel.h"
@interface GYTagTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIButton *subscribeLabel;

@end

@implementation GYTagTableViewCell

-(void)setModel:(GYSubTagModel *)model{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeLabel.text = model.theme_name;
    //self.subLabel.text = model.sub_number;
    NSString *string = [NSString stringWithFormat:@"%@人订阅",model.sub_number];
    NSInteger number = [model.sub_number integerValue];
    if (number >10000) {
        CGFloat num = number/10000.0;
      string = [NSString stringWithFormat:@"%.1f万人订阅",num];
        string = [string stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.subLabel.text = string;
    
}


-(void)setFrame:(CGRect)frame{
    frame.size.height -=1;
    [super setFrame:frame];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageV.layer.cornerRadius = 30;
    _imageV.layer.masksToBounds = YES;
    self.layoutMargins = UIEdgeInsetsZero;//分割线
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
