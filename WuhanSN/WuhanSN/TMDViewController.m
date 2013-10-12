//
//  TMDViewController.m
//  WuhanSN
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "TMDViewController.h"
#import "TMDDataFactory.h"
#import "SnData.h"
#import "TMDMapVC.h"

@interface TMDViewController ()

@end

@implementation TMDViewController
{
    NSArray         *_datas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"SN列表";
	
    _datas = [TMDDataFactory snDatas];
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    SnData *data = _datas[row];
    cell.textLabel.text = data.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SnData *data = _datas[row];
    
    TMDMapVC *mapVC = [TMDMapVC new];
    mapVC.data = data;
    
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            //annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
            //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

@end
