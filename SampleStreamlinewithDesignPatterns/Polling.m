//
//  Polling.m
//  TimerSample
//
//  Created by 古山 健司 on 12/12/07.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "Polling.h"

@interface Polling()
- (void)onTimer;
- (void)countStart;
@end

@implementation Polling
@synthesize myTimer = _myTimer;
@synthesize count = _count;
@synthesize isFinished = _isFinished;

- (void)onTimer
{
    LOG_METHOD;
    
    NSLog(@"%@:%d", [NSDate date], self.count);
    self.count++;
}
- (void)countStart
{
    LOG_METHOD;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    self.count = 0;
    int cc=0;
    for (int i = 0; i < 5; i+=1) {
        [NSThread sleepForTimeInterval:0.25];
        if (i%1 == 0) {
            LOG(@"%d", cc);
        }
        cc++;
    }    
    if ( ![NSThread isMainThread] )
    {
        LOG(@"Sub Thread");
        self.isFinished = YES;
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:cc] forKey:@"lastCount"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubThreadCountFinishedNotification" object:self  userInfo:userInfo];
    
    [pool drain];
}


- (void)start
{
    LOG_METHOD;
    [NSThread detachNewThreadSelector:@selector(countStart) toTarget:self withObject:nil];
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];

}

- (void)pause
{
    LOG_METHOD;
    [self.myTimer invalidate];
}

@end
