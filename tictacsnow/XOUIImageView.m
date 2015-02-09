//
//  XOUIImageView.m
//  tictacsnow
//
//  Created by Yan Yang on 2/9/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "XOUIImageView.h"

@implementation XOUIImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) changeState
{
    if (self.userInteractionEnabled == YES) {
        self.userInteractionEnabled = NO;
        self.alpha = 0.5;
    }
    else
    {
        self.userInteractionEnabled = YES;
        self.alpha = 1;
        [UIView animateWithDuration:2
                         animations:^{self.transform = CGAffineTransformMakeScale(4.0, 4.0);}
                         completion:^(BOOL completed){
                             
                         }
         ];
        [UIView animateWithDuration:2
                         animations:^{self.transform = CGAffineTransformMakeScale(1.0, 1.0);}
                         completion:^(BOOL completed){
                             
                         }
         ];
    }
}

@end
