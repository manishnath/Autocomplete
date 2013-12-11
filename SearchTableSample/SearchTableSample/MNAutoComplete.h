//
//  MNAutoComplete.h
//  SearchTableSample
//
//  Created by Manish on 10/12/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+encode.h"
@protocol AutocompleteDelgate <NSObject>
@optional
- (void)autocompleteDidReturn:(NSArray *)theCities;
- (void)autocompleteDidFailWithError:(NSError *)error;
@end
@interface MNAutoComplete : NSObject{
    BOOL isLoading;
    NSMutableData *receivedData;
    id <AutocompleteDelgate> delegate;
}

- (id)initWithDelegate:(id)theDelegate;
- (void)startWithKeyword:(NSString *)keyword;

@end
