//
//  DBStore.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/20/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class Domain;
@class Account;

@interface DBStore : NSObject
@property User *activeUser;
@property NSString *userPhoneNumber;

+ (DBStore *) getStore;
- (void)saveContext;
- (User *) newUser;
- (void)saveNewPhoneNumber:(NSString *) theNewPhoneNumber;

@end
