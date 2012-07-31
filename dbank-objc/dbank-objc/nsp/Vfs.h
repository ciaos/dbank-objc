//
//  Vfs.h
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-27.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSPClient.h"


@interface Vfs : NSPClient {

}

-(Vfs *)initWith:(NSString *)ses And:(NSString *)sec;

-(id)lsdir:(NSString *)path With:(NSArray *)fields And:(NSNumber *)type;
-(id)copyfile:(NSArray *)files To:(NSString *)path With:(NSDictionary *)attribute;
-(id)movefile:(NSArray *)files To:(NSString *)path With:(NSDictionary *)attribute;
-(id)rmfile:(NSArray *)files With:(NSNumber *)reverse And:(NSDictionary *)attribute;
-(id)mkdir:(NSArray *)dir At:(NSString *)path;
-(id)getattr:(NSArray *)files With:(NSArray *)fields;

@end
