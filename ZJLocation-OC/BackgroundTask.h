//
//  BackgroundTask.h
//  ZJLocation-OC
//
//  Created by ZeroJianMBP on 16/5/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundTask : NSObject

@property (nonatomic, assign)BOOL tasking;

- (void)registerBackgroundTask;
- (void)endBackgroundTask;

@end
