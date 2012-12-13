//
//  PollingController.m
//  TimerSample
//
//  Created by 古山 健司 on 12/12/07.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "PollingController.h"
#import "Polling.h"


@implementation PollingController
@synthesize delegate = _delegate;
@synthesize myPolling = _myPolling;
@synthesize pollings = _pollings;


static id _instance = nil;
+ (id)sharedInstance {
    LOG_METHOD;
    @synchronized(self) {
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

- (void)dealloc
{
    LOG_METHOD;
    self.myPolling = nil;
    [super dealloc];
}

- (id)init
{
    LOG_METHOD;
    self = [super init];
    if (self != nil) {
        _pollings = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)start
{
    LOG_METHOD;
    Polling *polling = [[Polling alloc] init];
    self.myPolling = polling;

    [polling release];
    [self.myPolling start];
    /* KVO(Key-Value Observing )通知 */
    [self.myPolling addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:NULL];

}

- (void)showData
{
    LOG_METHOD;
    LOG(@"show Data");
}

- (void)addPolling
{
    LOG_METHOD;
    Polling *polling = [[Polling alloc] init];
    [self.pollings addObject:polling];
    [polling release];
}

- (BOOL)delPollingAt:(NSInteger)index
{
    LOG_METHOD;
    [self.pollings removeObjectAtIndex:index];
    return YES;
}

/**
 * KVO通知を受けた後、delegate通知
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    LOG_METHOD;
    if ([keyPath isEqualToString:@"isFinished"]) {
        LOG(@"isFinished");
        [self.delegate notify];
    }
}


@end
