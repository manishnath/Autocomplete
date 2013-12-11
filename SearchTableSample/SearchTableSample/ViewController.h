//
//  ViewController.h
//  SearchTableSample
//
//  Created by Manish on 14/11/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"


@interface ViewController : UIViewController<SearchDelegate>
@property (nonatomic, strong) SearchViewController *searchTableController;
@end
