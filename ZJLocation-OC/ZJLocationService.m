//
//  ZJLocationService.m
//  ZJLocation-OC
//
//  Created by ZeroJianMBP on 16/5/10.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "ZJLocationService.h"
#import <UIKit/UIKit.h>
#import "BackgroundTask.h"

@implementation ZJLocationService
{
  NSMutableArray *backgroundLocations;
  NSTimer *timer;
  BackgroundTask *backgroundTask;
  double seconds;
  int locationCounts;
  
}

+ (id)sharedModel
{
  static id sharedMyModel = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedMyModel = [[self alloc] init];
  });
  return sharedMyModel;
}

- (id)init
{
  if (self = [super init]) {
    backgroundTask = [[BackgroundTask alloc] init];
    backgroundLocations = [[NSMutableArray alloc] initWithCapacity:15];
    seconds = 179;
    locationCounts = 5;
  }
  return self;
}

- (CLLocationManager *)locationManager {
  static CLLocationManager *_locationManager;
  
  @synchronized(self) {
    if (_locationManager == nil) {
      _locationManager = [[CLLocationManager alloc] init];
      _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
      _locationManager.delegate = self;
      _locationManager.pausesLocationUpdatesAutomatically = NO;
      _locationManager.allowsBackgroundLocationUpdates = YES;
      [_locationManager requestAlwaysAuthorization];
    }
  }
  return _locationManager;
}

+ (void)statrLocation
{
  if ([CLLocationManager locationServicesEnabled]) {
    [[[self sharedModel] locationManager] startUpdatingLocation];
    NSLog(@"begin updating location");
  }
}

+ (void)stopLocation
{
  [[[self sharedModel] locationManager] stopUpdatingLocation];
  NSLog(@"did stop location");
}

+ (void)backgroundForPauseTime:(double)time locationCounts:(int)counts
{
  if (time > 0 && time < 180) {
    [self sharedModel]->seconds = time;
  }
  if (counts > 1) {
    [self sharedModel]->locationCounts = counts;
  }
}

+ (void)backgroundForPauseTime:(double)time
{
  if (time > 0 && time < 180) {
    [self sharedModel]->seconds = time;
  }
}

+ (void)backgroundForLocationCounts:(int)counts
{
  if (counts > 1) {
    [self sharedModel]->locationCounts = counts;
  }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
  CLLocation *location = [locations lastObject];
  self.updateBlock(location);
  
  if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive ){
    
    NSLog(@"background location: %f",location.coordinate.latitude);
    
    [backgroundLocations addObject:location];
    
    
    if ([backgroundLocations count] == locationCounts) {
      NSLog(@"location counts: %d", locationCounts);
      [self begionBackgroundTask];
    }
  } else {
    [self initialBackgroundTask];
    if ([backgroundLocations count] > 0) {
      [backgroundLocations removeAllObjects];
    }
  }
}


- (void)begionBackgroundTask
{
  [self initialBackgroundTask];
  
  self.lastBlock([backgroundLocations lastObject]);
  
  [backgroundLocations removeAllObjects];
  
  timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(restartLocationUpdates) userInfo:nil repeats:NO];
  
  [backgroundTask registerBackgroundTask];
  
  [ZJLocationService stopLocation];
  
  NSLog(@" pause location: %f seconds", seconds);
}

- (void)restartLocationUpdates
{
  //do something
  
  [ZJLocationService statrLocation];
}

- (void)initialBackgroundTask
{
  if (backgroundTask.tasking) {
    [backgroundTask endBackgroundTask];
  }
  if (timer.isValid) {
  [timer invalidate];
  }
  timer = nil;
}


@end
