//
//  ViewController.m
//  ZJLocation-OC
//
//  Created by ZeroJianMBP on 16/5/10.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "ViewController.h"
#import "ZJLocationService.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longtudeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [ZJLocationService statrLocation];
  

  [ZJLocationService backgroundForPauseTime:30 locationCounts:4];
  
  __weak ViewController *weakSelf = self;
 
  [ZJLocationService sharedModel].updateBlock = ^(CLLocation *location) {
    weakSelf.latitudeLabel.text = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    weakSelf.longtudeLabel.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
  };
  
  [ZJLocationService sharedModel].lastBlock = ^(CLLocation *location) {
    NSLog(@"block backgroundLocation: %f", location.coordinate.latitude);
  };
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
