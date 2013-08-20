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
#import <NIAttributedLabel.h>


@interface MSViewController ()<UIScrollViewDelegate, NIAttributedLabelDelegate>
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

-(IBAction)pageChanged:(id)sender {
    // Set flag
    pageControlUsed = YES;
    // Get previous page number
    int page = _showPageControl.currentPage;
    previousPage = page;
    // Call loadShow for the new page
    [self loadShow:page];
    // Scroll scroll view to new page
    CGRect frame = _showScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [UIView animateWithDuration:.5 animations:^{
        [_showScrollView scrollRectToVisible:frame animated:NO];
    } completion:^(BOOL finished) {
        pageControlUsed = NO;
    }];
}

-(void)loadShow:(int)index {
    // 1 - Does the pages array contain the specified page?
    NSNumber *indexObj = $int(index);
    if (![loadedPages containsObject:indexObj]) {
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
        
        
//        // 6 - Display the show information
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(index * _showScrollView.bounds.size.width, 40, _showScrollView.bounds.size.width, 40)];
//        label.text = [showDict $for: @"title"];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont systemFontOfSize:18];
//        label.textAlignment = NSTextAlignmentCenter;
//        [_showScrollView addSubview:label];
        
        // 6 - Display the show information
        NIAttributedLabel* label = [[NIAttributedLabel alloc] initWithFrame:CGRectMake(index * _showScrollView.bounds.size.width, 40, _showScrollView.bounds.size.width, 40)];
        label.text = [showDict $for: @"title"];
        label.backgroundColor = [UIColor clearColor];
        label.linkColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = UITextAlignmentCenter;
        [label addLink: [NSURL URLWithString:[showDict $for: @"url"]] range:NSMakeRange(0, label.text.length)];
        label.delegate = self;
        [_showScrollView addSubview:label];
        
        // 6.1 - Create formatted airing date
        static NSDateFormatter *formatter = nil;
        if (!formatter) {
            formatter = $new(NSDateFormatter);
            formatter.dateStyle = NSDateFormatterLongStyle;
            formatter.timeStyle = NSDateFormatterShortStyle;
            formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
        }
        NSTimeInterval showAired = [[episodeDict $for: @"first_aired_localized"] doubleValue];
        NSString *showDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970: showAired]];
        // 6.2 - Create label to display episode info
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(index * _showScrollView.bounds.size.width, 360, _showScrollView.bounds.size.width, 60)];
        NSString* episode  = [NSString stringWithFormat:@"%02dx%02d - \"%@\"",
                              [[episodeDict valueForKey:@"season"] intValue],
                              [[episodeDict valueForKey:@"number"] intValue],
                              [episodeDict objectForKey:@"title"]];
        lbl.text = [NSString stringWithFormat:@"%@\n%@", episode, showDate];
        lbl.numberOfLines = 0;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor whiteColor];
        lbl.backgroundColor = [UIColor clearColor];
        [_showScrollView addSubview:lbl];
        
        
        // 6.3 - Get image
        NSString *posterUrl = [[showDict $for: @"images"] $for: @"poster"];
        if ([[UIScreen mainScreen] isRetinaDisplay]) {
            posterUrl = [posterUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"-300.jpg"];
        } else {
            posterUrl = [posterUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"-138.jpg"];
        }
        // 6.4 - Display image using image view
        UIImageView *posterImage = $new(UIImageView);
        // $new(class) is the same as [[class alloc] init] - courtesy of ConciseKit
        posterImage.frame = CGRectMake(index * _showScrollView.bounds.size.width + 90, 80, 150, 225);
        [_showScrollView addSubview:posterImage];
        // 6.5 - Asynchronously load the image
        [posterImage setImageWithURL:[NSURL URLWithString:posterUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        
        // 7 - Add the new page to the loadedPages array
        indexObj = [NSNumber numberWithInt:index];
        [loadedPages addObject:indexObj];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)sender {
    // Was the scrolling initiated via page control?
    if (pageControlUsed) {
        return;
    }
    // Figure out page to scroll to
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"offset:%f, pageWidth:%f, page:%d", sender.contentOffset.x, pageWidth, page);
    // Do not do anything if we're trying to go beyond the available page range
    if (page == previousPage || page < 0 || page >= _showPageControl.numberOfPages)
        return;
    previousPage = page;
    // Set the page control page display
    _showPageControl.currentPage = page;
    // Load the page
    [self loadShow:page];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

-(void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    [[UIApplication sharedApplication] openURL:result.URL];
}

@end
