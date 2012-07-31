//
//  MD5.h
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-26.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5Extensions)

-(NSString *) md5;

@end
