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
#import "TMDSnCell.h"
#import "UIView+LoadFromNib.h"

@interface TMDViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tv;

@end

@implementation TMDViewController
{
    NSArray         *_datas;
    SnData          *_currentData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"SN列表";
    _tv.backgroundColor = [UIColor colorWithWhite:.3 alpha:1];
	
    _datas = [TMDDataFactory snDatas];
    _tv.rowHeight = [TMDSnCell HEIGHT];
    _tv.separatorColor = [UIColor colorWithWhite:.4 alpha:.5];
    
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    static NSString *cellId = @"TMDSnCell";
    TMDSnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [TMDSnCell viewFromNibWithOwner:self];//[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell.btnMap addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnOrder addTarget:self action:@selector(showPhoneSheet:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    SnData *data = _datas[row];
    cell.lblName.text = data.name;
    cell.lblDescription.text = data.description;
    cell.ivPic.image = [UIImage imageNamed:@"default.jpg"];
    cell.tag = cell.btnMap.tag = cell.btnOrder.tag = row;
    
    cell.viewBg.backgroundColor = (row % 2) ? [UIColor colorWithWhite:.15 alpha:1] : [UIColor colorWithWhite:.1 alpha:1];
    
    return cell;
}

-(void)goMap:(UIButton *)sender
{
    int row = sender.tag;
    
    SnData *data = _datas[row];
    
    TMDMapVC *mapVC = [TMDMapVC new];
    mapVC.data = data;
    
    [self.navigationController pushViewController:mapVC animated:YES];
}

-(void)showPhoneSheet:(UIButton *)sender
{
    int row = sender.tag;
    _currentData = _datas[row];
    
    NSString *title = [NSString stringWithFormat:@"%@", _currentData.name];
    
    UIActionSheet *shit = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    NSArray *contacts = _currentData.contacts;
    
    int keyCount = 0;
    for (NSDictionary *dic in contacts)
    {
        NSString *key = dic.allKeys[0];
        [shit addButtonWithTitle:key];
        keyCount++;
    }
    
    [shit addButtonWithTitle:@"取消"];
    shit.cancelButtonIndex = keyCount;
    
    [shit showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        NSArray *contacts = _currentData.contacts;
        NSDictionary *dic = contacts[buttonIndex];
        NSString *number = dic.allValues[0];
        NSLog(@"phone number:%@", number);
        
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", number]];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //int row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    SnData *data = _datas[row];
//    
//    TMDMapVC *mapVC = [TMDMapVC new];
//    mapVC.data = data;
//    
//    [self.navigationController pushViewController:mapVC animated:YES];
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
