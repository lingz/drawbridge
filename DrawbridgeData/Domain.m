//
//  Domain.m
//  DrawbridgeData
//
//  Created by Pete Huang on 7/19/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import "Domain.h"
#import "Account.h"

@implementation Domain

@dynamic host;
@dynamic user;
@dynamic accounts;

- (NSDictionary *) toDict
{
    NSDictionary *accountsDict = @{};
    NSSet *accountsSet = self.accounts;
    if (accountsSet != nil) {
        for (Account *account in accountsSet) {
            [accountsDict setValue:[account toDict] forKey:account.hashedPassword];
        }
    }
    return @{
                @"host": self.host,
                @"accounts": accountsDict
            };
}

+ (Domain *) fromDict: (NSDictionary *) domainDict
{
    Domain *theNewDomain = [Domain MR_createEntity];
    theNewDomain.host = [domainDict valueForKeyPath:@"host"];
    
    NSDictionary *accounts = [domainDict valueForKeyPath:@"accounts"];
    
    if (accounts) {
        NSArray *allKeys = [accounts allKeys];
        for (NSString *key in allKeys) {
            NSDictionary *accountDict = [accounts valueForKeyPath:key];
            Account *accountObject = [Account fromDict:accountDict];
            [theNewDomain addAccountsObject:accountObject];
        }
    }
    return theNewDomain;
}

@end
