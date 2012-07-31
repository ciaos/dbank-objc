Dbank SDK Objective-C
=====================

> basic dbank api(lsdir/movefile/copyfile/rmfile ...)
> It's easy to upload a file to netdisk.
> Download a file is easier.

* * *

Follow me
---------

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