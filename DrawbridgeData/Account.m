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

+ (Account *) fromDict: (NSDictionary *) accountDict
{
    Account *theNewAccount = [Account MR_createEntity];
    theNewAccount.hashedPassword = [accountDict valueForKeyPath:@"hashedPassword"];
    theNewAccount.encryptedPassword = [accountDict valueForKeyPath:@"encryptedPassword"];
    theNewAccount.username = [accountDict valueForKeyPath:@"username"];

    return theNewAccount;
}

@end
