//
//  TMDViewController.m
//  ArrestsPlotter
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "TMDViewController.h"
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"
#import "MyLocation.h"
// Add at the top of the file
#import "MBProgressHUD.h"



#define METERS_PER_MILE 1609.344

@interface TMDViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)refreshTapped:(id)sender;

@end

@implementation TMDViewController



// Add new method above refreshTapped
- (void)plotCrimePositions:(NSData *)responseData {
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    NSArray *data = [root objectForKey:@"data"];
    
    //for (NSArray *row in data)
    {
        NSNumber * latitude = @(39.281516);//[[row objectAtIndex:22]objectAtIndex:1];
        NSNumber * longitude = @(-76.580806);//[[row objectAtIndex:22]objectAtIndex:2];
        NSString * crimeDescription = @"Tom was murdered here!";//[row objectAtIndex:18];
        NSString * address = @"Broadway";//[row objectAtIndex:14];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;
        MyLocation *annotation = [[MyLocation alloc] initWithName:crimeDescription address:address coordinate:coordinate] ;
        [_mapView addAnnotation:annotation];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//114.3223,30.558785

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}

- (IBAction)refreshTapped:(id)sender {
    // 1
    MKCoordinateRegion mapRegion = [_mapView region];
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    // 2
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"command" ofType:@"json"];
    NSString *formatString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
    NSString *json = [NSString stringWithFormat:formatString,
                      centerLocation.latitude, centerLocation.longitude, 0.5*METERS_PER_MILE];
    
    // 3
    NSURL *url = [NSURL URLWithString:@"http://data.baltimorecity.gov/api/views/INLINE/rows.json?method=index"];
    
    // 4
    ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:url];
    __weak ASIHTTPRequest *request = _request;
    
    request.requestMethod = @"POST";
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    // 5
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSLog(@"Response: %@", responseString);
        
        [self plotCrimePositions:request.responseData];
        // Add at start of setCompletionBlock and setFailedBlock blocks
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
        // Add at start of setCompletionBlock and setFailedBlock blocks
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    // 6
    [request startAsynchronous];
    // Add right after [request startAsynchronous] in refreshTapped action method
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading arrests...";
    
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    MyLocation *location = (MyLocation*)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

@end
