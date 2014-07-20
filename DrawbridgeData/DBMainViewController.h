//
//  DBMainViewController.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "DBFlipsideViewController.h"

@interface DBMainViewController : UIViewController <DBFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
