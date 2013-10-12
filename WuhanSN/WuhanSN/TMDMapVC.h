//
//  TMDMapVC.h
//  WuhanSN
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnData.h"
#import "MyLocation.h"

@interface TMDMapVC : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) SnData  *data;
@end
