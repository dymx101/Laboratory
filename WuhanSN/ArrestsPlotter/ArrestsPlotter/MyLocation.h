//
//  MyLocation.h
//  ArrestsPlotter
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject<MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;
@end
