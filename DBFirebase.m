//
//  DBFirebase.m
//  DrawbridgeData
//
//  Created by Pete Huang on 7/20/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import "DBFirebase.h"
#import <Firebase/Firebase.h>
#import "User.h"

NSString *const FIREBASE_URL = @"https://drawbridgeauth.firebaseIO.com";

@interface DBFirebase()

@property Firebase *accounts;
@property Firebase *pollingUser;

@end

@implementation DBFirebase


+ (DBFirebase *) getFirebase {
    static DBFirebase *singleton = nil;
    @synchronized(self) {
        if (singleton == nil) {
            singleton = [[self alloc] init];
        }
    }
    return singleton;
}

- (id) init
{
    if (self = [super init]) {
        self.fb = [[Firebase alloc] initWithUrl:FIREBASE_URL];
        self.accounts = [self.fb childByAppendingPath:@"accounts"];
    }
    return self;
}

- (void) saveUser: (User *)user
{
    Firebase *userNode = [self.accounts childByAppendingPath:user.phoneNumber];
    [userNode setValue:[user toDict]];
}

- (void) loadUser: (NSString *)phoneNumber
{
    if (self.pollingUser)
    {
        [self.pollingUser removeAllObservers];
    }
    Firebase *userNode = [self.accounts childByAppendingPath:phoneNumber];
    [userNode observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *userDict = snapshot.value;
        User *theNewUser = [User fromDict:userDict];
        // call delegate
        if (self.delegate) {
            [self.delegate handleFBLoadUser:theNewUser];
        }
    }];
    self.pollingUser = userNode;
    
}

@end
