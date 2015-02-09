//
//  ViewController.h
//  tictacsnow
//
//  Created by Yan Yang on 2/8/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XOUIImageView.h"
#import "GridUIView.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>



@interface ViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet XOUIImageView *XX;
@property (weak, nonatomic) IBOutlet XOUIImageView *OO;
@property (strong, nonatomic) NSMutableArray* GridArray;
@property (nonatomic) NSInteger EmptyNumber;
@property (strong, nonatomic) AVAudioPlayer *sound;

- (IBAction)infoPage:(id)sender;

- (IBAction)BackToGame:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *InfoPage;


@end

