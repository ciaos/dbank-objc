//
//  Vfs.m
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-27.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import "Vfs.h"


@implementation Vfs

-(Vfs *)initWith:(NSString *)ses And:(NSString *)sec
{
	self = [super initWith:ses And:sec];
	
	return self;
}

//列举文件目录
-(id)lsdir:(NSString *)path With:(NSArray *)fields And:(NSNumber *)type
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          path, @"path",fields,@"fields",nil];
	
	id res = [super callService:@"nsp.vfs.lsdir" With:send];
	
	[send autorelease];
	
	return res;
}

//复制文件/文件夹
-(id)copyfile:(NSArray *)files To:(NSString *)path With:(NSDictionary *)attribute
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          path, @"path",files,@"files",attribute,@"attribute",nil];
	
	id res = [super callService:@"nsp.vfs.copyfile" With:send];
	
	[send autorelease];
	
	return res;
}

//移动文件/文件夹
-(id)movefile:(NSArray *)files To:(NSString *)path With:(NSDictionary *)attribute
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          path, @"path",files,@"files",attribute,@"attribute",nil];
	
	id res = [super callService:@"nsp.vfs.movefile" With:send];
	
	[send autorelease];
	
	return res;
}

//删除文件/文件夹
-(id)rmfile:(NSArray *)files With:(NSNumber *)reverse And:(NSDictionary *)attribute
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          files, @"files",reverse,@"reverse",attribute,@"attribute",nil];
	
	id res = [super callService:@"nsp.vfs.rmfile" With:send];
	
	[send autorelease];
	
	return res;
}

//创建文件夹
-(id)mkdir:(NSArray *)dir At:(NSString *)path
{
    return nil;
}

//获取文件信息
-(id)getattr:(NSArray *)files With:(NSArray *)fields
{
	NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          files, @"files",fields,@"fields",nil];
	
	id res = [super callService:@"nsp.vfs.getattr" With:send];
	
	[send autorelease];
	
	return res;
}

@end
