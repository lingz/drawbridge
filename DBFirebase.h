//
//  DBFirebase.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/20/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@class User;

FOUNDATION_EXPORT NSString *const FIREBASE_URL;

@protocol DBFirebaseDelegate <NSObject>

@required
- (void) handleFBLoadUser: (User *)theNewUser;

@end

@interface DBFirebase : NSObject


@property id<DBFirebaseDelegate> delegate;
@property Firebase *fb;

+ (DBFirebase *) getFirebase;
- (void) saveUser: (User *)user;
- (void) loadUser: (NSString *)phoneNumber;
- (void) setDelegate: (id<DBFirebaseDelegate>)delegate;


@end

