//
//  GYLoginField.m
//  Budejie
//
//  Created by YOUNG on 16/7/27.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYLoginField.h"

@implementation GYLoginField

-(void)awakeFromNib{
    //光标变白色
    self.tintColor = [UIColor whiteColor];
    
    UILabel *placeholder = [self valueForKey:@"placeholderLabel"];
    placeholder.textColor    = [UIColor lightGrayColor];
    
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
}

-(void)editBegin{
    UILabel *placeholder = [self valueForKey:@"placeholderLabel"];
    placeholder.textColor    = [UIColor whiteColor];
}

-(void)editEnd{
    UILabel *placeholder = [self valueForKey:@"placeholderLabel"];
    placeholder.textColor    = [UIColor lightGrayColor];
}











@end
