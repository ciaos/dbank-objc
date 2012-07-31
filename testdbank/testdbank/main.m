//
//  main.m
//  test
//
//  Created by Ciaos on 12-7-30.
//  Copyright (c) 2012年 Ciaos House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSPClient.h"
#import "Vfs.h"
#import "User.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        //初始化nspclient对象
        NSPClient *nc = [[[NSPClient alloc]
                          initWith:@"iuTeAN9uaQ6xYuCt8f7uaL4Hwua5CgiU2J0kYJq01KtsA4DY" 
                          And:@"c94f61061b46668c25d377cead92f898"] autorelease];
        
        //调用Vfs服务显示文件目录
        Vfs *vfs = [nc service:[Vfs alloc]];
        
        NSArray *fields = [NSArray arrayWithObjects:@"name",@"url",@"size",@"type",nil];
        NSNumber *num = [NSNumber numberWithInt:3];
        
        id res = [vfs lsdir:@"/Netdisk/" With:fields And:num];
        NSLog(@"lsdir = %@",res);
        
        //上传文件到Dbank
        NSArray *files = [NSArray arrayWithObjects:@"/Users/penjin/Projects/a.txt",nil];
        res = [nc upload:@"/Netdisk/" With:files];
        NSLog(@"upload = %@",res);
        
        //从Dbank下载文件到本地磁盘
        BOOL dl = [nc download:@"/Netdisk/a.txt" To:@"/Users/penjin/a.txt"];
        NSLog(@"download = %d",dl);
        
    }
    return 0;
}

