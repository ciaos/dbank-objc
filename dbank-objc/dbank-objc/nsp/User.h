//
//  User.h
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-27.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSPClient.h"

@interface User : NSPClient {

}

-(NSMutableDictionary *)getInfo:(NSArray *)attrs;
-(NSNumber *)update:(NSDictionary *)attrs;

@end
