//
//  SearchViewController.h
//  SearchTableSample
//
//  Created by Manish on 14/11/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchDelegate <NSObject>

-(void)didSelectSearchedString:(NSString *)selectedString;

@end

@interface SearchViewController : UITableViewController{
    id <SearchDelegate> delegate;
}
@property (nonatomic, weak) id <SearchDelegate> delegate;
@property (nonatomic, strong) NSArray *dataSource;
-(void)reloadDataWithSource:(NSArray *)sourceArray;
-(void)toggleHidden:(BOOL)toggle;
@end
