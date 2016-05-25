#### Background Location Tracking , Batterysave in Background Location Model

#### This demo will allow you be batterysave in backgroundLocation,You can set a time interval to stop location.



- make sure you checked `Background Model`  - `Location updates`
 
- make sure your project `Info` added Key `NSLocationAlwaysUsageDescription`
 
 
### Requirements
---
- ios 7.0 +
- xcode 7.3

### Usage
---
updating location:

	[ZJLocationService startLocation];
	
stopUpdating location:
	
	[ZJLocationService stopLocation];
	
default and maximal timeInterval is 179 seconds, if you custom timeInterval:

	[ZJLocationService backgroundForPauseTime:100];
	
you can custom background location number (default: 5)
	
	[ZJLocationService backgroundForLocationCounts:10];
	
At the same time set them

	[ZJLocationService backgroundForPauseTime:100 locationCounts:10];
	
if you need currentLocation:

	[ZJLocationService sharedModel].updateBlock = ^(CLLocation *location) {
 	NSLog(@"currentLocation: %f", location.coordinate.latitude);
  	};

If you need the last location before each stopLocation:

	[ZJLocationService sharedModel].lastBlock = ^(CLLocation *location) {
		NSLog(@"lastBackgroundLocation: %f", location.coordinate.latitude);
	};


### License

ZJLocation is released under the MIT license. See LICENSE for details.