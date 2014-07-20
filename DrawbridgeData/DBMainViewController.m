//
//  DBMainViewController.m
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "DBMainViewController.h"
#import "Account.h"
#import "Domain.h"
#import "User.h"
#import "DBAppDelegate.h"
#import "DBStore.h"

@interface DBMainViewController ()

@property (weak, nonatomic) IBOutlet UITextView *currentPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *theNewPhoneNumberField;
@property NSString *phoneNumber;
@property DBStore *store;


@end

@implementation DBMainViewController

- (IBAction)newUser:(id)sender {
    [self.store newUser];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.store = [DBStore getStore];
    [self refreshCurrentPhoneField];

}

- (void)refreshCurrentPhoneField
{
    self.currentPhoneNumber.text = self.store.userPhoneNumber;
}
- (IBAction)saveNewPhoneNumber:(id)sender {
    NSString *theNewPhoneNumber = self.theNewPhoneNumberField.text;
    
    [self.store saveNewPhoneNumber: theNewPhoneNumber];
    [self refreshCurrentPhoneField];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(DBFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (IBAction)touchEvent:(id)sender {
}
@end
