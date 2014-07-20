//
//  DBFlipsideViewController.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBFlipsideViewController;

@protocol DBFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(DBFlipsideViewController *)controller;
@end

@interface DBFlipsideViewController : UIViewController

@property (weak, nonatomic) id <DBFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
