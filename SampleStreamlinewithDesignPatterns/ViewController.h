//
//  ViewController.h
//  SampleStreamlinewithDesignPatterns
//
//  Created by 古山 健司 on 12/12/13.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PollingController.h"
@class Polling;
/**
 * @brief ViewController（メイン画面）
 */
@interface ViewController : UIViewController <UIAlertViewDelegate, PollingControllerDelegate>
@property (nonatomic, readwrite)int count;
@property (nonatomic, retain)Polling *polling;
@property (nonatomic, readwrite)BOOL isStart;
@end
