//
//  CustomButton.m
//  ParticleButton
//
//  Created by FYZH on 14-2-22.
//  Copyright (c) 2014年 Liang HaiHu. All rights reserved.
//

#import "CustomButton.h"
#import "EmitterView.h"
@implementation CustomButton
{
    CAEmitterLayer *fireEmitter; //1
    EmitterView *emitterView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"CustomButton");
        
////        self.backgroundColor = [UIColor blackColor];
//        [self setTitle:@"Button" forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:@"bombed.png"] forState:UIControlStateDisabled];
        [self setImage:[UIImage imageNamed:@"bomb.png"] forState:UIControlStateDisabled];
        [self setEnabled:NO];
        emitterView = [[EmitterView alloc] initWithFrame:CGRectZero];
        [self addSubview:emitterView];
    }
    return self;
}


-(void)showAnimation:(BOOL) show{
//    emitterVie
    if (show) {
        [emitterView startEmitterView];
    }
    else{
        [emitterView stopEmitterView];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{
    //绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRoundedRect(path, nil, self.bounds, self.bounds.size.width/2, self.bounds.size.width/2);
//    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.repeatCount = MAXFLOAT;
//    animation.repeatCount = 1;
    animation.path = path;
    [emitterView.layer addAnimation:animation forKey:@"test"];
}


@end
