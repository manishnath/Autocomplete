//
//  NSString+urlEncode.m
//  StationLocator
//
//  Created by Anson Li on 10-02-19.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "NSString+encode.h"


@implementation NSString (encode)

- (NSString *)urlEncode {
	NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
	return result;
}

- (NSString *)trim {
	if (self != nil) 
		return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	else
		return nil;
}

- (BOOL)containsSubstring:(NSString *)part {
	NSRange range = [[self lowercaseString] rangeOfString:part];
	if (range.location == NSNotFound) {
		return NO;
	}
	else {
		return YES;
	}

}

@end
