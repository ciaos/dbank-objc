//
//  User.m
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-27.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import "User.h"

@implementation User

//获取网盘用户信息
-(id)getInfo:(NSArray *)attrs
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          attrs, @"attrs",nil];
	
	id res = [super callService:@"nsp.user.getInfo" With:send];
	
	[send autorelease];
	
	return res;
}

//更新网盘用户信息
-(id)update:(NSDictionary *)attrs
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          attrs, @"attrs",nil];
	
	id res = [super callService:@"nsp.user.update" With:send];
	
	[send autorelease];
	
	return res;
}

@end
