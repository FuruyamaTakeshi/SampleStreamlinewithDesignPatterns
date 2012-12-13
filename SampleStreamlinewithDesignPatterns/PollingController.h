//
//  PollingController.h
//  TimerSample
//
//  Created by 古山 健司 on 12/12/07.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSKeyValueObserving.h>

@class Polling;

@protocol PollingControllerDelegate
@optional
- (void)notify;
@end
/**
 * @brief ポーリング処理コントロールクラス(Singletonモデル）UI層が使用する
 */
@interface PollingController : NSObject
/* ポーリングインスタンス */
@property (nonatomic, retain) Polling *myPolling;
@property (nonatomic, assign) id <PollingControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *pollings;
/**
 * @brief クラスメソッド
 * @return インスタンス
 */
+ (id)sharedInstance;
/**
 * @brief　ポーリング開始メソッド
 */
- (void)start;
/**
 * @brief
 */
- (void)showData;
/**
 * @brief ポーリング追加
 * @param [in] ポーリングオブジェクト
 */
- (void)addPolling;
/**
 * @brief ポーリング削除
 * @param [in] 削除するポーリングのインデックス
 * @retrun 
 */
- (BOOL)delPollingAt:(NSInteger)index;
@end
