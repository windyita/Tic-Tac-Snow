//
//  XOUIImageView.h
//  tictacsnow
//
//  Created by Yan Yang on 2/9/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XOUIImageView : UIImageView

@property (nonatomic) CGPoint initialpoint;

-(void) changeState;

@end
