//
//  ViewController.m
//  GesturesExample
//
//  Created by Erick Bennett on 12/15/14.
//  Copyright (c) 2014 Erick Bennett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect luigis_frame = CGRectMake(0, 0, 160, 160);
    
    self.luigi_image = [[UIImageView alloc] initWithFrame:luigis_frame];
    
    self.luigi_image.image = [UIImage imageNamed:@"Luigi_Image.png"];
    
    self.luigi_image.center = self.view.center;
    
    [self.view addSubview:self.luigi_image];

    //Tap gesture recognizer with 3 taps
    UITapGestureRecognizer *tap_luigi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLuigiDetected:)];
    tap_luigi.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:tap_luigi];
    
    //Swipe gesture activated with a left swipe
    UISwipeGestureRecognizer *left_swipe_luigi = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeLuigiDetected:)];
    left_swipe_luigi.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left_swipe_luigi];
    
    //Swipe gesture activated with a right swipe
    UISwipeGestureRecognizer *right_swipe_luigi = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeLuigiDetected:)];
    right_swipe_luigi.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right_swipe_luigi];
    
    //Long press gesture set for 1 touch at 3 seconds
    UILongPressGestureRecognizer *long_press_luigi = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressLuigiDetected:)];
    long_press_luigi.minimumPressDuration = 3;
    long_press_luigi.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:long_press_luigi];
    
    //Screen edge pan, initiated from right edge of screen
    UIScreenEdgePanGestureRecognizer *luigi_screen_edge = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(luigiScreenEdgeDetected:)];
    luigi_screen_edge.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:luigi_screen_edge];
 
    
    //Pan gesture
    UIPanGestureRecognizer *luigi_pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(luigiPanDetected:)];
    [self.view addGestureRecognizer:luigi_pan];
    
    
    //In order for Pan and swip to work together, you must tell the pan gesture to activate only after the left (and right) swipe gestures have failed.
    [luigi_pan requireGestureRecognizerToFail:left_swipe_luigi];
    
    [luigi_pan requireGestureRecognizerToFail:right_swipe_luigi];
}

-(void) luigiPanDetected:(UIGestureRecognizer *)gesture {
    
    //Get the x,y coordinates of the touch position on the screen.
    CGPoint tapPoint = [gesture locationInView:self.view];
    
    //State began happens when pan is first started
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //We are storing luigis current screen position for later.
        self.currentPosition = self.luigi_image.center;
        
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        //State changed is while your finger is moving. We are moving luigis position around based on the tap points x,y coordinates.
        self.luigi_image.center = tapPoint;

    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        //When gesture is finished (finger is lifted), put luigi back to the original position we stored in StateBegan
        self.luigi_image.center = self.currentPosition;
    }
}

-(void) luigiScreenEdgeDetected:(UIGestureRecognizer *)gesture {
    CGRect newFrame = self.luigi_image.frame;
    newFrame.size.height = 160;
    newFrame.size.width = 160;
    
    [UIView animateWithDuration:1 animations:^{
        self.luigi_image.frame = newFrame;
        self.luigi_image.center = self.view.center;
    }];
}

-(void) longPressLuigiDetected:(UIGestureRecognizer *)gesture {
    
    CGRect newFrame = self.luigi_image.frame;
    newFrame.size.height = 50;
    newFrame.size.width = 50;
    
    [UIView animateWithDuration:1 animations:^{
        self.luigi_image.frame = newFrame;
        self.luigi_image.center = self.view.center;
    }];
}

-(void) tapLuigiDetected:(UIGestureRecognizer *)gesture {
    self.luigi_image.hidden = !self.luigi_image.hidden;
}

-(void) leftSwipeLuigiDetected:(UIGestureRecognizer *) gesture {
    [UIView animateWithDuration:1 animations:^{
        self.luigi_image.alpha = 0;
    }];
}

-(void) rightSwipeLuigiDetected:(UIGestureRecognizer *) gesture {
    [UIView animateWithDuration:1 animations:^{
        self.luigi_image.alpha = 1;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
