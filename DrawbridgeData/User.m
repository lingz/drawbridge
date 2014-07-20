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


@end
