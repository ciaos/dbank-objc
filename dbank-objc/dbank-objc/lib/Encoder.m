//
//  Encoder.m
//  dbank-sdk-objc
//
//  Created by Ciaos on 12-7-27.
//  Copyright 2012 Ciaos House. All rights reserved.
//

#import "Encoder.h"

@implementation NSString (EncodeExtensions)

- (NSString *)urlencode
{
	NSString *encodedValue = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	encodedValue = [encodedValue stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
	encodedValue = [encodedValue stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
	encodedValue = [encodedValue stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
	encodedValue = [encodedValue stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    return encodedValue;
}

@end
