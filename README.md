Dbank SDK Objective-C
=====================
封装了基本的dbank api,第三方开发者可基于它开发网盘应用
* * *

Description
-----------

> 1. basic dbank api(lsdir/movefile/copyfile/rmfile ...)
> 2. It's easy to upload a file to netdisk.
> 3. It's easier to download a file from netdisk.

How to use
----------

*	包含头文件和引用链接库**nspclient.dylib**
<pre><code>
#import "NSPClient.h"
#import "Vfs.h"
#import "User.h"
</code></pre>

*   创建nspclient对象（使用鉴权sid与secret）
<pre><code>
NSPClient *nc = [[[NSPClient alloc]
                          initWith:@"iuTeAN9uaQ6xYuCt8f7uaL4Hwua5CgiU2J0kYJq01KtsA4DY" 
                          And:@"c94f61061b46668c25d377cead92f898"] autorelease];
</code></pre>

*   调用网盘Vfs/User服务
<pre><code>
Vfs *vfs = [nc service:[Vfs alloc]]; 
NSArray *fields = [NSArray arrayWithObjects:@"name",@"url",@"size",@"type",nil];
id res = [vfs lsdir:@"/Netdisk/" With:fields And:[NSNumber numberWithInt:3]];
NSLog(@"lsdir = %@",res);
</code></pre>

*   上传一个文件到dbank
<pre><code>
NSArray *files = [NSArray arrayWithObjects:@"/Users/penjin/Projects/a.txt",nil];
res = [nc upload:@"/Netdisk/" With:files];
NSLog(@"upload = %@",res);
</code></pre>

*	从网盘下载文件
<pre><code>
BOOL dl = [nc download:@"/Netdisk/a.txt" To:@"/Users/penjin/a.txt"];
NSLog(@"download = %d",dl);
</code></pre>

See Also
--------

具体使用方法参照 [dbank开放平台](http://open.dbank.com)

Weibo Account
-------------

Have a question? [@littley](http://weibo.com/littley)

