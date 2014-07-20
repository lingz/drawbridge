//
//  DBStore.m
//  DrawbridgeData
//
//  Created by Pete Huang on 7/20/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import "DBStore.h"
#import "Account.h"
#import "Domain.h"
#import "User.h"
#import "DBCrypto.h"
#import "DBFirebase.h"

@interface DBStore()

@property NSUserDefaults *defaults;
@property DBFirebase *fbInterface;

@end

@implementation DBStore


+ (DBStore *) getStore {
    static DBStore *singleton = nil;
    @synchronized(self) {
        if (singleton == nil) {
            singleton = [[self alloc] init];
        }
    }
    return singleton;
}

- (User *)newUser
{
    if (self.userPhoneNumber != nil) {

        
        self.activeUser = [User MR_createEntity];

        
        self.activeUser.secret = [DBCrypto randomSecret:30];

        self.activeUser.phoneNumber = self.userPhoneNumber;

        [self saveContext];
        
        return self.activeUser;
    }
    return nil;
}

- (void)saveNewPhoneNumber:(NSString *) theNewPhoneNumber {
    [self.defaults setObject:theNewPhoneNumber forKey:@"phoneNumber"];
    [self.defaults synchronize];
    
    User *theNewUser = [self phoneNumberToUser:theNewPhoneNumber];
    
    self.userPhoneNumber = theNewPhoneNumber;
    if (theNewUser)
    {
        [self changeActiveUser:theNewUser];
    }
    // we need a new firebase
    [self syncFirebase];
}

- (User *) phoneNumberToUser: (NSString *) phoneNumber {
    User *userWithPhoneNumber = [User MR_findFirstByAttribute:@"phoneNumber" withValue:phoneNumber];
    
    return userWithPhoneNumber;
}

- (id) init {
    if (self = [super init]) {
        // Firebase init
        self.fbInterface = [DBFirebase getFirebase];
        self.fbInterface.delegate = self;
        
        self.defaults = [NSUserDefaults standardUserDefaults];
        [self extractOptions];
        if (self.userPhoneNumber) {
            self.activeUser = [self phoneNumberToUser: self.userPhoneNumber];
        }
        [self syncFirebase];
    }
    return self;
}

- (void) extractOptions {
    self.userPhoneNumber = [self.defaults stringForKey:@"phoneNumber"];
}

- (void) saveUserToFirebase {
    if (self.activeUser) {
        [self.fbInterface saveUser:self.activeUser];
    }
}

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

- (void)syncFirebase {
    [self.fbInterface loadUser:self.activeUser.phoneNumber];
}

- (void)handleFBLoadUser:(User *)theNewUser
{
    if (self.activeUser) {
        [self.activeUser MR_deleteEntity];
    }
    [self saveNewPhoneNumber: self.activeUser.phoneNumber];
    
    if (theNewUser)
    {
        [self saveContext];
        [self changeActiveUser:theNewUser];
    }
}

- (void)changeActiveUser:(User *)theNewUser
{
    self.activeUser = theNewUser;
    // call the delegate
    [self.userChangeDelegate handleUserUpdate];
}
@end
