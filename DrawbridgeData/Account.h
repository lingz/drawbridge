//
//  Account.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Domain;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * hashedPassword;
@property (nonatomic, retain) NSString * encryptedPassword;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) Domain *domain;

- (NSDictionary *) toDict;
+ (Account *) fromDict: (NSDictionary *)accountDict;

@end
