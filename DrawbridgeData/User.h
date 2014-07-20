//
//  User.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Domain;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * secret;
@property (nonatomic, retain) NSSet *domains;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addDomainsObject:(Domain *)value;
- (void)removeDomainsObject:(Domain *)value;
- (void)addDomains:(NSSet *)values;
- (void)removeDomains:(NSSet *)values;

@end
