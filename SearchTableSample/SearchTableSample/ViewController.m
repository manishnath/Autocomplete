//
//  ViewController.m
//  SearchTableSample
//
//  Created by Manish on 14/11/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "ViewController.h"
#import "MNAutoComplete.h"

@interface ViewController ()<AutocompleteDelgate>{
     MNAutoComplete *_autoComplete;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadAutocompletandSearchTable];
}

-(void)loadAutocompletandSearchTable{
    _autoComplete = [[MNAutoComplete alloc] initWithDelegate:self];
    self.searchTableController = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    self.searchTableController.tableView.frame = CGRectMake(0, 60, self.view.frame.size.width, 400);
    self.searchTableController.delegate = self;
    [self.view addSubview:self.searchTableController.tableView];
    [self.searchTableController toggleHidden:YES];

}


-(NSArray *)getSearchHistory{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SEARCH_HISTORY"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Delegate 
-(void)didSelectSearchedString:(NSString *)selectedString{
    NSLog(@"SELECTED %@",selectedString);
}

#pragma mark - Autocomplete Delegate
- (void)autocompleteDidReturn:(NSArray *)results {
	NSLog(@"results %@",results);
    [self.searchTableController reloadDataWithSource:results];
}

-(void)autocompleteDidFailWithError:(NSError *)error{
    
}

#pragma mark - Search Text Field

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSArray *sourceArray = [NSMutableArray arrayWithArray:[self getSearchHistory]];
    [self.searchTableController reloadDataWithSource:sourceArray];
    
    NSLog(@"search history %@",sourceArray);
    [self.searchTableController toggleHidden:NO];
    return YES;
}// return NO to disallow editing.

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.text.length>=2) {
        [_autoComplete startWithKeyword:textField.text];
        
    }
    
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    if ([self.searchtextField.text caseInsensitiveCompare:@"current location"] == NSOrderedSame) {
//        [self updateStationsatcurrentLocation];
//    }
//    else{
//        [self searchChevronStationsForLocation:self.searchtextField.text];
//    }
    
    [self.searchTableController toggleHidden:YES];

    
    return YES;
}// called when 'return' key pressed. return NO to ignore.

@end
