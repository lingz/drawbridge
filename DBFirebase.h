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

@interface DBFirebase : NSObject

@property Firebase *fb;

+ (DBFirebase *) getFirebase;
- (void) saveUser: (User *)user;


@end
