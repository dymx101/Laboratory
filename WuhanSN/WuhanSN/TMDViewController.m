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

@interface TMDViewController ()

@end

@implementation TMDViewController
{
    NSArray         *datas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    datas = [TMDDataFactory snDatas];
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
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
    
    SnData *data = datas[row];
    cell.textLabel.text = data.name;
    
    return cell;
}

@end
