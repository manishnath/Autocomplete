//
//  MNAutoComplete.m
//  SearchTableSample
//
//  Created by Manish on 10/12/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MNAutoComplete.h"

@implementation MNAutoComplete

- (id)initWithDelegate:(id<AutocompleteDelgate>)theDelegate {
	self = [super init];
	if (self) {
		isLoading = NO;
		delegate = theDelegate;
	}
	return self;
}

- (void)startWithKeyword:(NSString *)keyword {
    NSString *key = @"AIzaSyCMhMnuF-DLC2_IHWIiT7Bbz3-kRgi5CTU";
    
    
    //	NSURL *link = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=%@&sensor=true&input=%@&location=37.76373,-122.398835&radius=500",key,[keyword urlEncode]]];
    NSURL *link = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=%@&sensor=true&input=%@",key,[keyword urlEncode]]];
    
    //	NSURL *link = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.chevronwithtechron.com/api/app/techron2go/ws_cities_autocomplete_r2.aspx?srch=%@&device=%@",[keyword urlEncode],[[[UIDevice currentDevice] identifierForVendor] UUIDString]]];
	
	NSURLRequest *theRequest= [NSURLRequest requestWithURL:link
											   cachePolicy:NSURLRequestUseProtocolCachePolicy
										   timeoutInterval:10.0f];
	
	if (!isLoading) {
		NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		
		receivedData = [[NSMutableData alloc] init];
		[theConnection start];
        
		isLoading = YES;
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	}
	
	NSLog(@"url:%@", link);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if(isLoading) {
		[receivedData setLength:0];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // append the new data to the receivedData
	if(isLoading) {
		[receivedData appendData:data];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if(isLoading) {
        if (delegate != nil && [delegate respondsToSelector:@selector(autocompleteDidFailWithError:)]) {
            [delegate autocompleteDidFailWithError:error];
        }
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		isLoading = NO;
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"connection finished");
	NSMutableArray *cityList = [[NSMutableArray alloc] init];;
    
	if(isLoading && receivedData.length > 0) {
        NSError *error = nil;
        NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
        if (!error) {
            [cityList addObjectsFromArray:parsedJSON[@"predictions"]];
            NSLog(@"city list %@",cityList);
            if (delegate != nil && [delegate respondsToSelector:@selector(autocompleteDidReturn:)]) {
                [delegate autocompleteDidReturn:cityList];
            }
        }
        else if (delegate != nil && [delegate respondsToSelector:@selector(autocompleteDidFailWithError:)]) {
            [delegate autocompleteDidFailWithError:error];
        }
		
		isLoading = NO;
	}
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	
	
}


@end
