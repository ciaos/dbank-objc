//
//  NSPClient.h
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-26.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSPClient : NSObject {
	bool sysLevel;
	
	NSString *sid;
	NSString *secret;
}

@property (nonatomic,retain) NSString *sid;
@property (nonatomic,retain) NSString *secret;

-(NSPClient *)initWith:(NSString *)ses And:(NSString *)sec;

-(id)upload:(NSString *)dirpath With:(NSArray *)files;

-(bool)download:(NSString *)objfile To:(NSString *)savename;

-(id)callService:(NSString *)srvname With:(id)params;

-(id)service:(id)srv;

@end
