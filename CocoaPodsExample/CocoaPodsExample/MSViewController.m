//
//  MSViewController.m
//  CocoaPodsExample
//
//  Created by Dong Yiming on 7/16/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "MSViewController.h"
#import "TraktAPIClient.h"
#import <AFNetworking.h>
#import <ConciseKit.h>
#import <SSCategories.h>


@interface MSViewController ()
{
    NSArray *jsonResponse;
    BOOL pageControlUsed;
    int previousPage;
    NSMutableSet *loadedPages;
}
@property (weak, nonatomic) IBOutlet UIScrollView *showScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *showPageControl;

@end

@implementation MSViewController


// http://api.trakt.tv/calendar/shows.json/e613c1dc22e70ad633c06ebf3fd2995a

-(void)viewDidLoad {
    [super viewDidLoad];
    // 1 - Create trakt API client
    TraktAPIClient* client = [TraktAPIClient sharedClient];
    // 2 - Create date instance with today's date
    NSDate* today = [NSDate date];
    // 3 - Create date formatter
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    NSString* todayString = [formatter stringFromDate:today];
    // 4 - Create API query request
    NSString* path = [NSString stringWithFormat:@"calendar/shows.json/%@/%@/%d", kTraktAPIKey, todayString, 1];
    NSURLRequest* request = [client requestWithMethod:@"GET" path:path parameters:nil];
    
    // 4.1 - Initialize variables
    loadedPages = [NSMutableSet set];
    previousPage = -1;
    
    // 5 - Create JSON request operation
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 6 - Request succeeded block
        NSLog(@"%@", JSON);
        
        // 6.1 - Load JSON into internal variable
        jsonResponse = JSON;
        // 6.2 - Get the number of shows
        int shows = 0;
        for (NSDictionary* day in jsonResponse) {
            shows += [[day $for: @"episodes"] count];
            // $for: above is the same as objectForKey: - we're using ConciseKit here.
        }
        // 6.3 - Set up page control
        _showPageControl.numberOfPages = shows;
        _showPageControl.currentPage = 0;
        // 6.4 - Set up scroll view
        _showScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * shows, _showScrollView.frame.size.height);
        // 6.5 - Load first show
        [self loadShow:0];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // 7 - Request failed block
    }];
    // 8 - Start request
    [operation start];
}

-(IBAction)pageChanged:(id)sender
{
    
}

-(void)loadShow:(int)index {
    // 1 - Does the pages array contain the specified page?
    if (![loadedPages containsObject:$int(index)]) {
        // $int(x) is the same as [NSNumber numberWithInt:x]
        // 2 - Find the show for the given index
        int shows = 0;
        NSDictionary *show = nil;
        for (NSDictionary *day in jsonResponse) {
            int count = [[day $for: @"episodes"] count];
            // 3 - Did we find the right show?
            if (index < shows + count) {
                show = [[day $for:@"episodes"] $at: index-shows];
                break;
            }
            // 4 - Increment the shows counter
            shows += count;
        }
        // 5 - Load the show information
        NSDictionary *episodeDict = [show $for:@"episode"];
        NSDictionary *showDict = [show $for:@"show"];
        // 6 - Display the show information
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(index * _showScrollView.bounds.size.width, 40, _showScrollView.bounds.size.width, 40)];
        label.text = [showDict $for: @"title"];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        [_showScrollView addSubview:label];
        // 7 - Add the new page to the loadedPages array
        [loadedPages addObject:$int(index)];
    }
}

@end
