//
//  NSString+urlEncode.h
//  StationLocator
//
//  Created by Anson Li on 10-02-19.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (encode) 

- (NSString *)urlEncode;
- (NSString *)trim;
- (BOOL)containsSubstring:(NSString *)part;

@end
