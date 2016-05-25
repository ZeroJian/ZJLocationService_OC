//
//  ZJLocationService.h
//  ZJLocation-OC
//
//  Created by ZeroJianMBP on 16/5/10.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ZJLocationService : NSObject <CLLocationManagerDelegate>

typedef void (^didUpdateLocation)(CLLocation *location);
typedef void (^lastBackgroundLocation)(CLLocation *location);

@property (nonatomic, copy) didUpdateLocation updateBlock;
@property (nonatomic, copy) lastBackgroundLocation lastBlock;

+ (void)statrLocation;
+ (void)stopLocation;
+ (ZJLocationService *)sharedModel;

+ (void)backgroundForPauseTime:(double)time locationCounts:(int)counts;
+ (void)backgroundForPauseTime:(double)time;
+ (void)backgroundForLocationCounts:(int)counts;


- (CLLocationManager *)locationManager;
- (void)begionBackgroundTask;
- (void)initialBackgroundTask;
@end
