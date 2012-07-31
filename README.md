Dbank SDK Objective-C
=====================
* * *

Description
-----------

> 1. basic dbank api(lsdir/movefile/copyfile/rmfile ...)
> 2. It's easy to upload a file to netdisk.
> 3. It's easier to download a file from netdisk.

How to use
----------

*	Import header files And **nspclient.dylib**
<pre><code>
#import "NSPClient.h"
#import "Vfs.h"
#import "User.h"
</code></pre>

*   Create nspclient object
<pre><code>
NSPClient *nc = [[[NSPClient alloc]
                          initWith:@"iuTeAN9uaQ6xYuCt8f7uaL4Hwua5CgiU2J0kYJq01KtsA4DY" 
                          And:@"c94f61061b46668c25d377cead92f898"] autorelease];
</code></pre>

*   Call Vfs/User API
<pre><code>
Vfs *vfs = [nc service:[Vfs alloc]]; 
NSArray *fields = [NSArray arrayWithObjects:@"name",@"url",@"size",@"type",nil];
id res = [vfs lsdir:@"/Netdisk/" With:fields And:[NSNumber numberWithInt:3]];
NSLog(@"lsdir = %@",res);
</code></pre>

*   Upload a file
<pre><code>
NSArray *files = [NSArray arrayWithObjects:@"/Users/penjin/Projects/a.txt",nil];
res = [nc upload:@"/Netdisk/" With:files];
NSLog(@"upload = %@",res);
</code></pre>

*	Download a file
<pre><code>
BOOL dl = [nc download:@"/Netdisk/a.txt" To:@"/Users/penjin/a.txt"];
NSLog(@"download = %d",dl);
</code></pre>

See Also
--------

[open.dbank.com](http://open.dbank.com)

Weibo Account
-------------

Have a question? @littley

