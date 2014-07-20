//
//  Account.m
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import "Account.h"
#import "Domain.h"


@implementation Account

@dynamic hashedPassword;
@dynamic encryptedPassword;
@dynamic username;
@dynamic domain;

- (NSDictionary *) toDict
{
    return @{
                @"hashedPassword": self.hashedPassword,
                @"encryptedPassword": self.encryptedPassword,
                @"username": self.username
            };
}

@end
