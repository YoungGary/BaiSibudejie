//
//  GYFastLoginView.m
//  Budejie
//
//  Created by YOUNG on 16/7/27.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYFastLoginView.h"

@implementation GYFastLoginView

+(instancetype)fastLoginView{
    return [[[NSBundle mainBundle]loadNibNamed:@"GYFastLoginView" owner:self options:nil] firstObject];
}


@end
