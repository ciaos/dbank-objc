//
//  NSPClient.m
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-26.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import "NSPClient.h"
#import "JSONKit.h"
#import "Encoder.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MD5.h"
#import "Vfs.h"
#import "User.h"

NSString *NSP_APP = @"nsp_app";
NSString *NSP_SID = @"nsp_sid";
NSString *NSP_KEY = @"nsp_key";
NSString *NSP_SVC = @"nsp_svc";
NSString *NSP_TS  = @"nsp_ts";
NSString *NSP_PARAMS = @"nsp_params";
NSString *NSP_FMT = @"nsp_fmt";
NSString *NSP_TSTR = @"nsp_tstr";

NSString *NSP_URL = @"http://api.dbank.com/rest.php";


@implementation NSPClient

//鉴权账号与密钥
@synthesize sid;
@synthesize secret;

-(void)setSid:(NSString *)ses AndSecret:(NSString *)sec
{
	self.sid = [[NSString alloc] initWithString: ses];
	self.secret = [[NSString alloc] initWithString: sec];
}

//初始化nspclient对象
-(NSPClient *)initWith:(NSString *)ses And:(NSString *)sec
{
	self = [super init];
	
	if (self) {
		if([ses isEqualToString: [NSString stringWithFormat:@"%d",[ses integerValue]]])
		{
			sysLevel = YES;
		}
		else
		{
			sysLevel = NO;
		}
		[self setSid:ses AndSecret:sec];
	}
	return self;
}

//获取验证密钥
-(NSString *)getNSPKey:(NSString *)sec With:(NSMutableDictionary *)mdic
{
	NSString *md5str = [NSString stringWithString:sec];
	
	int count = [mdic count];
	
	NSArray *keys = [[mdic allKeys] sortedArrayUsingSelector:@selector(compare:)];
	
	id key,val;
	for(int i=0;i<count;i++)
	{
		key = [keys objectAtIndex:i];
		val = [mdic objectForKey:key];
		
		NSString *k = [NSString stringWithFormat:@"%@",key];
		NSString *v = [NSString stringWithFormat:@"%@",val];
		
		md5str = [md5str stringByAppendingString:k];
		md5str = [md5str stringByAppendingString:v];
	}
	
	return [[md5str md5] uppercaseString];
}

//拼装get参数
-(NSString *)getPostData:(NSMutableDictionary *)mdic
{
	NSString *data = @"";
	NSString *md5str = self.secret;
	
	int count = [mdic count];
	
	NSArray *keys = [[mdic allKeys] sortedArrayUsingSelector:@selector(compare:)];
	
	id key,val;
	for(int i=0;i<count;i++)
	{
		key = [keys objectAtIndex:i];
		val = [mdic objectForKey:key];
		
		md5str = [md5str stringByAppendingString:key];
		md5str = [md5str stringByAppendingString:val];
		
		data = [data stringByAppendingFormat:@"%@=%@&",key,[val urlencode]];
	}
	
	data = [data stringByAppendingString:NSP_KEY];
	data = [data stringByAppendingString:@"="];
	data = [data stringByAppendingString:[[md5str md5] uppercaseString]];
    
	return data;
}

//调用平台服务
-(id)callService:(NSString *)srvname With:(id)params
{
	NSMutableDictionary *mdic = [[[NSMutableDictionary alloc] init] autorelease];
	if (sysLevel) {
		[mdic setObject:self.sid forKey:NSP_APP];
	}
	else {
		[mdic setObject:self.sid forKey:NSP_SID];
	}
	
	@try {
		NSString *series = [params JSONString];
		if (series == nil) {
			series = @"null";
		}
        else {
            NSArray *keys = [params allKeys];
            int j,c = [params count];
            id key,val;
            
            for(j = 0;j < c;j ++)
            {
                key = [keys objectAtIndex:j];
                val = [params objectForKey:key];
                
                if ([val isKindOfClass:[NSString class]]) {
                }
                else {
                    val = [val JSONString];
                }
                [mdic setObject:val forKey:key];
            }
        }
        
        //[mdic setObject:series forKey:NSP_PARAMS];
        
		[mdic setObject:srvname forKey:NSP_SVC];
		[mdic setObject:[NSString stringWithFormat:@"%d",time(0)] forKey:NSP_TS];
		[mdic setObject:@"JSON" forKey:NSP_FMT];
		
		NSString *data = [self getPostData:mdic];
		NSString *urlstr = [NSString stringWithFormat:@"%@?%@",NSP_URL,data];		
        
		NSURL *url = [NSURL URLWithString:urlstr];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];  
		[request startSynchronous]; 
        
		NSError *error = [request error];  
		if(!error){  
			NSData *response = [request responseData];
			return [response objectFromJSONData];
		}  
	}
	@catch (NSException * e) {
		NSLog(@"%@ %@",[e name],[e reason]);
        return nil;
	}
	
	return nil;
}

-(id)upload:(NSString *)dirpath With:(NSArray *)files
{
	//获取上传地址以及临时密钥等信息
	id upauth = [self callService:@"nsp.vfs.upauth" With:nil];
    
	//上传文件
	int i,count = [files count];
	id file;
	JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
	NSMutableArray *upresult = [[[NSMutableArray alloc] init] autorelease];
	
	for(i = 0;i < count;i ++)
	{
		file = [files objectAtIndex:i];
		
		NSString *up = [NSString stringWithFormat:@"http://%@/upload/up.php",[upauth valueForKey:@"nsp_host"]];
		NSURL *url = [NSURL URLWithString:up];  
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];  
		
		NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
		[mdic setObject:[upauth valueForKey:@"nsp_tapp"] forKey:NSP_APP];
		[mdic setObject:@"JSON" forKey:NSP_FMT];
		[mdic setObject:[NSString stringWithFormat:@"%d",time(0)] forKey:NSP_TS];
		[mdic setObject:[upauth valueForKey:@"nsp_tstr"] forKey:NSP_TSTR];
		[mdic setObject:[self getNSPKey:[upauth valueForKey:@"secret"] With:mdic] forKey:NSP_KEY];
		
		NSArray *keys = [mdic allKeys];
		int j,c = [mdic count];
		id key,val;
		
		for(j = 0;j < c;j ++)
		{
			key = [keys objectAtIndex:j];
			val = [mdic objectForKey:key];
			
			[request setPostValue:val forKey:key];
		}
		[request setFile:file forKey:@"Filedata"]; 
		[request startSynchronous];
		
		NSError *err = [request error];  
		if (!err) {  
			NSString *res = [request responseString]; 
			id upret = [jd objectWithUTF8String:(const unsigned char *)[res UTF8String] length:(unsigned int)[res length]];
			id filedata = [upret objectForKey:@"Filedata"];
			
			NSDictionary *mkfile = [[[NSDictionary alloc] initWithObjectsAndKeys:
									[filedata objectForKey:@"path"],@"url",
									[filedata objectForKey:@"sig"],@"sig",
									[filedata objectForKey:@"nsp_fid"],@"md5",
									[filedata objectForKey:@"name"],@"name",
									[filedata objectForKey:@"size"],@"size",
									[filedata objectForKey:@"ts"],@"ts",
									@"File",@"type",nil] autorelease];
									
			
			[upresult addObject:mkfile];
		}
		
		[mdic release];
	}
    
	//更新网盘文件信息
    NSDictionary *mkfile = [[NSDictionary alloc] initWithObjectsAndKeys: dirpath, @"path",[upresult JSONString],@"files",nil];
    
	id mkres = [self callService:@"nsp.vfs.mkfile" With:mkfile];
    
    [mkfile release];
	
	return mkres;
}

-(bool)download:(NSString *)objfile To:(NSString *)savename
{
    //获取网盘文件下载地址
    NSArray *files = [NSArray arrayWithObject:objfile];
    NSArray *fields = [NSArray arrayWithObject:@"url"];
    NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          files, @"files",fields,@"fields",nil];

    id res = [self callService:@"nsp.vfs.getattr" With:send];
    
    
    //下载文件
    @try {
         NSString *downurl = [[[res objectForKey:@"successList"] objectAtIndex:0] objectForKey: @"url"];

         NSURL *url = [NSURL URLWithString:downurl];  
         ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];  
         [request setDownloadDestinationPath:savename];  
         [request startSynchronous];  
    }
    @catch (NSException *e) {
        NSLog(@"%@", [e name]);
        return NO;
    }
	 
	return YES;
}

-(id)service:(id)srv
{
	if([srv isKindOfClass:[Vfs class]])
	{
		srv = [[srv initWith:self.sid And:self.secret] autorelease];
		return srv;
	}
	else if([srv isKindOfClass:[User class]])
	{
		srv = [[srv init] autorelease];
		return srv;
	}
	
	return nil;
}


@end
