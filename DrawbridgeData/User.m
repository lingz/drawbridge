//
//  User.m
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import "User.h"
#import "Domain.h"


@implementation User

@dynamic phoneNumber;
@dynamic secret;
@dynamic domains;

- (NSDictionary *) toDict
{
    NSDictionary *domainsDict = @{};
    NSSet *domainsSet = self.domains;
    if (domainsSet != nil) {
        for (Domain *domain in domainsSet) {
            [domainsDict setValue:[domain toDict] forKey:domain.host];
        }
    }
    return @{
                @"phoneNumber": self.phoneNumber,
                @"secret": self.secret,
                @"domains": domainsDict
            };
}

+ (User *) fromDict: (NSDictionary *)dict
{
    User *theNewUser = [User MR_createEntity];
    theNewUser.phoneNumber = [dict valueForKeyPath:@"phoneNumber"];
    theNewUser.secret = [dict valueForKeyPath:@"secret"];
    
    NSDictionary *domains = [dict valueForKeyPath:@"domains"];
    
    if (domains) {
        NSArray *allKeys = [domains allKeys];
        for (NSString *key in allKeys) {
            NSDictionary *domainDict = [domains valueForKeyPath:key];
            Domain *domainObject = [Domain fromDict:domainDict];
            [theNewUser addDomainsObject:domainObject];
        }
    }
    return theNewUser;
}


@end
