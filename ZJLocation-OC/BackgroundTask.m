//
//  BackgroundTask.m
//  ZJLocation-OC
//
//  Created by ZeroJianMBP on 16/5/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "BackgroundTask.h"
#import <UIKit/UIKit.h>
#import "ZJLocationService.h"

@implementation BackgroundTask
{
  UIBackgroundTaskIdentifier taskInvalid;
  BOOL timeOut;
}

- (void)registerBackgroundTask
{
  
  self.tasking = YES;
  UIApplication *application = [UIApplication sharedApplication];
  taskInvalid  = [application beginBackgroundTaskWithExpirationHandler:^{
    timeOut = YES;
    [self endBackgroundTask];
  }];
  NSLog(@"registerBackgroundTask");
}

- (void)endBackgroundTask
{
  if (timeOut) {
    [ZJLocationService statrLocation];
  }
  self.tasking = false;
  [[UIApplication sharedApplication] endBackgroundTask:(taskInvalid)];
  taskInvalid = UIBackgroundTaskInvalid;
  NSLog(@"endBackgroundTask");
}

@end
