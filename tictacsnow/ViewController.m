//
//  ViewController.m
//  tictacsnow
//
//  Created by Yan Yang on 2/8/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initialState];
    [self addGestureRecognizers];
    
}

- (void)initialState{
    int index=0;
    self.EmptyNumber = 9;
    self.GridArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= 9; i++) {
        GridUIView* grid = (GridUIView*)[self.view viewWithTag:i];
        [self.GridArray addObject:grid];
    }
    
    for (GridUIView* grid in self.GridArray) {
        grid.GridTag = index;
        index++;
        
        for (UIView* subView in grid.subviews) {
            [subView removeFromSuperview];
        }
    }

    //intialize x and o status
    self.XX.initialpoint = self.XX.center;
    self.OO.initialpoint = self.OO.center;
    [self.XX setUserInteractionEnabled:YES];
    [self.OO setUserInteractionEnabled:NO];
    [self.XX setAlpha:1];
    [self.OO setAlpha:0.5];
    //x first
    [UIView animateWithDuration:2
                     animations:^{self.XX.transform = CGAffineTransformMakeScale(4.0, 4.0);}
                     completion:^(BOOL completed)
     {
     }
     ];
    [UIView animateWithDuration:2
                     animations:^{self.XX.transform = CGAffineTransformMakeScale(1.0, 1.0);}
                     completion:^(BOOL completed)
     {
     }
     ];
    
}

- (void)addGestureRecognizers{
    //O recognizer
    UIPanGestureRecognizer *OimageRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveHandle:)];
    [OimageRecognizer setDelegate:self];
    [self.OO addGestureRecognizer: OimageRecognizer];
    
    //X recognizer
    UIPanGestureRecognizer *XimageRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveHandle:)];
    [XimageRecognizer setDelegate:self];
    [self.XX addGestureRecognizer: XimageRecognizer];
    
}


-(void)moveHandle:(UIPanGestureRecognizer*)gestureRecognizer
{
    XOUIImageView *newimage = (XOUIImageView*)[gestureRecognizer view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"begin" ofType:@"wav"];
        self.sound = [[AVAudioPlayer alloc]initWithContentsOfURL:
                            [NSURL fileURLWithPath:path] error:NULL];
        [self.sound play];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint offset = [gestureRecognizer translationInView:self.view];
        [newimage setCenter:CGPointMake(newimage.center.x+offset.x, newimage.center.y+offset.y)];
        [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        BOOL OccupiedIndex = TRUE;
        for (UIView* v in self.GridArray)
        {
            if (CGRectIntersectsRect(v.frame, newimage.frame))
            {
                if ([[v subviews] count] == 0)
                {
                    OccupiedIndex = FALSE;
                    UIImageView* temp = [[UIImageView alloc] initWithImage:[newimage image]];
                    
                    CGRect frame = temp.frame;
                    frame.size.width = v.frame.size.width;
                    frame.size.height = v.frame.size.height;
                    temp.frame = frame;
                    
                    [v addSubview:temp];
                    
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"wav"];
                    self.sound = [[AVAudioPlayer alloc]initWithContentsOfURL:
                                        [NSURL fileURLWithPath:path] error:NULL];
                    [self.sound play];
                    [self.OO changeState];
                    [self.XX changeState];
                    
                    ((GridUIView*) v).GridTag = newimage.tag;
                    self.EmptyNumber--;
                    
                    [self checkResult];
                    break;
                }
            }
        }
        if (OccupiedIndex) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"wav"];
            self.sound = [[AVAudioPlayer alloc]initWithContentsOfURL:
                                [NSURL fileURLWithPath:path] error:NULL];
            [self.sound play];
            [UIView animateWithDuration:1.0
                             animations:^{newimage.center = newimage.initialpoint;}
                             completion:^(BOOL completed)
             {
             }
             ];
        }
    }
}

- (void)checkResult{
    int i;
    NSInteger tag;
    NSInteger IndexArray[9]={0,1,2,3,4,5,6,7,8};
    for (i = 0; i<9; i++)
    {
        GridUIView* v = (GridUIView*)[self.GridArray objectAtIndex:i];
        IndexArray[i] = v.GridTag;
    }
    if (IndexArray[0]==IndexArray[1]&&IndexArray[1]==IndexArray[2])
    {
        if (IndexArray[0]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:0 endGrid:2];
    }else if (IndexArray[3]==IndexArray[4]&&IndexArray[4]==IndexArray[5]){
        if (IndexArray[3]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:3 endGrid:5];
    }else if (IndexArray[6]==IndexArray[7]&&IndexArray[6]==IndexArray[8]){
        if (IndexArray[6]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:6 endGrid:8];
    }else if (IndexArray[0]==IndexArray[3]&&IndexArray[0]==IndexArray[6]){
        if (IndexArray[0]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:0 endGrid:6];
    }else if (IndexArray[1]==IndexArray[4]&&IndexArray[4]==IndexArray[7]){
        if (IndexArray[1]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:1 endGrid:7];
    }else if (IndexArray[2]==IndexArray[5]&&IndexArray[2]==IndexArray[8]){
        if (IndexArray[2]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:2 endGrid:8];
    }else if (IndexArray[0]==IndexArray[4]&&IndexArray[0]==IndexArray[8]){
        if (IndexArray[0]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:0 endGrid:8];
    }else if (IndexArray[2]==IndexArray[4]&&IndexArray[2]==IndexArray[6]){
        if (IndexArray[2]==11) {tag=11;}
        else{tag=22;}
        [self Winline:tag startGrid:2 endGrid:6];
    }else if (self.EmptyNumber == 0) {
        tag=33;
        [self Winline:tag startGrid:0 endGrid:0];
    }
    
}

-(void) Winline: (NSInteger) winnerTag startGrid:(NSInteger)start endGrid:(NSInteger)end{

    NSString* Winner;

    [self.XX setUserInteractionEnabled:NO];
    [self.OO setUserInteractionEnabled:NO];
    
    if (winnerTag == 11) {
        Winner = @"X is the Winner! Congratulations!";
    }
    else if(winnerTag == 22)
    {
        Winner =@"O is the Winner! Congratulations!";
    }
    else
    {
        Winner = @"Full grid! Please try again!";
    }
    
    
    [self GameOver:[[NSString alloc] initWithFormat:@"%@",Winner]];
    
}

-(void)GameOver:(NSString*)theMessage{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
    self.sound = [[AVAudioPlayer alloc]initWithContentsOfURL:
                        [NSURL fileURLWithPath:path] error:NULL];
    [self.sound play];
    
    UIAlertView* GameOver = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                       message:theMessage
                                                      delegate:self
                                             cancelButtonTitle:@"New Game" otherButtonTitles:nil, nil];
    GameOver.tag = 122;
    [GameOver show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 122) {
        [self initialState];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (IBAction)infoPage:(id)sender {
    [UIView animateWithDuration:1.0
                     animations:^{
                         UIView* grid = [self.view viewWithTag:2];
                         self.InfoPage.center = grid.center;
                     }
                     completion:^(BOOL completed){
                     }
     ];
}

- (IBAction)BackToGame:(id)sender {
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.InfoPage.center = CGPointMake(self.InfoPage.center.x, -self.InfoPage.frame.size.height);
                     }
                     completion:^(BOOL completed){
                     }
     ];
}
@end
