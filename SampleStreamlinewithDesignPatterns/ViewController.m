//
//  ViewController.m
//  SampleStreamlinewithDesignPatterns
//
//  Created by 古山 健司 on 12/12/13.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "ViewController.h"

#import "Polling.h"

@interface ViewController ()
- (void)onTimer:(id)sender;
- (void)didReceiveNotificaton:(NSNotification*)notification;
@end

@implementation ViewController
@synthesize count = _count;
@synthesize polling = _polling;
@synthesize isStart = _isStart;

- (void)dealloc
{
    self.polling = nil;
    [super dealloc];
}

- (void)onTimer:(id)sender {
    LOG_METHOD;
    LOG(@"%d", self.count);
    self.count++;
}

- (void)viewDidLoad
{
    LOG_METHOD;
    [super viewDidLoad];
    self.count = 0;
	// Do any additional setup after loading the view, typically from a nib.
    
    self.isStart = YES;
    
    PollingController *controller = [PollingController sharedInstance];
    controller.delegate = self;
    [controller showData];
    [controller start];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 20, 120, 40);
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pauseButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 80, 120, 40);
    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(pauseButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificaton:) name:@"SubThreadCountFinishedNotification" object:nil];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeAllActionsWithTarget:self];
    
}
- (void)countStart {
    /*サブスレッドでタイマー処理実施*/
    LOG_METHOD;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}
- (void)didReceiveMemoryWarning
{
    LOG_METHOD;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Button Action
- (void)startButtonDidPush
{
    LOG_METHOD;
    if (!self.isStart) {
        [self.polling start];
    }
    else
        LOG(@"isStarted");
}
- (void)pauseButtonDidPush
{
    LOG_METHOD;
    if (self.isStart) {
        [self.polling pause];
    }
    else
        LOG(@"now paused");
}
#pragma mark -
#pragma mark delegate
- (void)notify
{
    LOG_METHOD;
    LOG(@"delegate notify");
    if ([NSThread isMainThread]) {
        LOG(@"Main Thread");
    }
    /* 　UIで処理させる場合はMain Thread での操作を行う */
    [self performSelectorOnMainThread:@selector(myAlertShow) withObject:nil waitUntilDone:NO];
}

- (void)myAlertShow
{
    LOG_METHOD;
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Notification did Received" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] autorelease ];
    [alert show];
}

#pragma mark -
#pragma mark NSNotification

- (void)didReceiveNotificaton:(NSNotification*)notification
{
    LOG_METHOD;
    NSNumber *num = [[notification userInfo] objectForKey:@"lastCount"];
    NSLog(@"Notification did Receive : %@", num);
}

@end
