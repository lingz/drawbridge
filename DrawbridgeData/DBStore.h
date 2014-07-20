//
//  DBStore.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/20/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBFirebase.h"

@class User;
@class Domain;
@class Account;

@protocol DBStoreUserDelegate <NSObject>

- (void) handleUserUpdate;

@end

@protocol DBStoreMessageDelegate <NSObject>

- (void) handleMessageUpdate;

@end

@interface DBStore : NSObject<DBFirebaseDelegate>
@property User *activeUser;
@property NSString *userPhoneNumber;
@property id<DBStoreUserDelegate> userChangeDelegate;
@property id<DBStoreMessageDelegate> messageChangeDelegate;


+ (DBStore *) getStore;
- (void)saveContext;
- (User *) newUser;
- (void)saveNewPhoneNumber:(NSString *) theNewPhoneNumber;
- (void)saveUserToFirebase;
- (void)handleFBLoadUser:(User *)theNewUser;


@end
