//
//  TMDMapVC.m
//  WuhanSN
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "TMDMapVC.h"

@interface TMDMapVC ()

@end

@implementation TMDMapVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = _data.name;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = _data.latitude;
    zoomLocation.longitude= _data.longitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    
    MyLocation *annotation = [[MyLocation alloc] initWithName:_data.name address:_data.address coordinate:zoomLocation] ;
    [_mapView addAnnotation:annotation];
}


@end
