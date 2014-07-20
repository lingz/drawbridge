//
//  Domain.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Domain : NSManagedObject

@property (nonatomic, retain) NSString * host;
@property (nonatomic, retain) NSManagedObject *user;
@property (nonatomic, retain) NSSet *accounts;
@end

@interface Domain (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(NSManagedObject *)value;
- (void)removeAccountsObject:(NSManagedObject *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

- (NSDictionary *) toDict;

@end
