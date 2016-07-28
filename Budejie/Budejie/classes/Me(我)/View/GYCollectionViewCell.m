//
//  GYCollectionViewCell.m
//  Budejie
//
//  Created by YOUNG on 16/7/28.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "GYMeModel.h"
@interface GYCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end


@implementation GYCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(GYMeModel *)item    {
    _item = item;
    [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.nameLabel.text = item.name;
    
}



@end
