//
//  Polling.h
//  TimerSample
//
//  Created by 古山 健司 on 12/12/07.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief　ポーリング処理クラスタイマーを別スレッドで動作
 */
@interface Polling : NSObject
@property (nonatomic, retain)NSTimer *myTimer;
@property (nonatomic, readwrite)int count;
@property (nonatomic, readwrite)BOOL isFinished;
/**
 * @brief ポーリング処理開始
 */
- (void)start;
/**
 * @brief　ポーリング処理一時停止
 */
- (void)pause;
@end
