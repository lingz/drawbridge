//
//  DBCrypto.h
//  DrawbridgeData
//
//  Created by Pete Huang on 7/20/14.
//  Copyright (c) 2014 Pete Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCrypto : NSObject
+ (NSString *) randomSecret: (int) len;


@end


