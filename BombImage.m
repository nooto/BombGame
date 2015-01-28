//
//  BombImage.m
//  BombGame
//
//  Created by GaoAng on 15/1/28.
//  Copyright (c) 2015年 SH. All rights reserved.
//

#import "BombImage.h"

@implementation BombImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"1.png"],
                             [UIImage imageNamed:@"2.png"],
                             [UIImage imageNamed:@"3.png"],
                             [UIImage imageNamed:@"4.png"],
                             [UIImage imageNamed:@"5.png"],
                             [UIImage imageNamed:@"6.png"],
                             [UIImage imageNamed:@"7.png"],nil];
        self.animationImages = gifArray; //动画图片数组
        self.animationDuration = 0.5; //执行一次完整动画所需的时长
        self.animationRepeatCount = MAXFLOAT;  //动画重复次数
    }
    return self;
}

-(void)showImage{
    [self startAnimating];
}

-(void)showSuspendImge{
    [self stopAnimating];
    self.image = [UIImage imageNamed:@"1.png"];
}


-(void)showEndIamge{
    [self stopAnimating];
    self.image = [UIImage imageNamed:@"endBomb.png"];
}
@end
