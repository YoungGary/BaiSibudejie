//
//  GYLoginView.m
//  Budejie
//
//  Created by YOUNG on 16/7/27.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYLoginView.h"
@interface GYLoginView()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation GYLoginView




+(instancetype)loginView{
    return [[[NSBundle mainBundle]loadNibNamed:@"GYLoginView" owner:self options:nil] firstObject];
}


+(instancetype)registerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"GYLoginView" owner:self options:nil] lastObject];
}

-(void)awakeFromNib{
    UIImage *image = _loginButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height *0.5];
    [_loginButton setBackgroundImage:image forState:UIControlStateNormal];
    
}

@end
