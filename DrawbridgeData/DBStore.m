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

@interface DBStore()

@property NSUserDefaults *defaults;
@property NSString *currentPhoneNumber;

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
    if (self.currentPhoneNumber) {
        
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
    self.activeUser = theNewUser;
}

- (User *) phoneNumberToUser: (NSString *) phoneNumber {
    User *userWithPhoneNumber = [User MR_findFirstByAttribute:@"phoneNumber" withValue:phoneNumber];
    
    return userWithPhoneNumber;
}

- (id) init {
    if (self = [super init]) {
        self.defaults = [NSUserDefaults standardUserDefaults];
        [self extractOptions];
    }
    return self;
}

- (void) extractOptions {
    self.userPhoneNumber = [self.defaults stringForKey:@"phoneNumber"];
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
@end
