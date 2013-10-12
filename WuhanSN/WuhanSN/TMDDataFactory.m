//
//  TMDDataFactory.m
//  WuhanSN
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "TMDDataFactory.h"
#import "SnData.h"

@implementation TMDDataFactory

static NSMutableArray *snDatas = nil;

+(NSMutableArray *)snDatas
{
    if (snDatas == nil)
    {
        snDatas = [NSMutableArray array];
        
        SnData *data = [SnData new];
        data.name = @"凤凰水上明珠";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"曾经理":@"13886195879"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"长江大酒店";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"少鹰":@"15271909791"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"汇申会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"王经理":@"15927093911"}, @{@"李经理":@"15971499391"}, @{@"钟经理":@"13871171531"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"循礼门某会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"张经理":@"15972039022"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"军悦";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"姚经理":@"13720387073"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"华云";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"李经理":@"15071395059"}, @{@"李丽":@"1307122988"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"玉泉";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"汪经理":@"13277067121"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"OK100";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"宋经理":@"13517285082"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"圣宝龙";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"成经理":@"13638694476"}, @{@"李经理":@"15102720577"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"华天";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"柯经理":@"13517226099"}, @{@"张经理":@"13971009271"}, @{@"夏经理":@"13871274116"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"桂林山水";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"余经理":@"13517255523"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"御泉";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"王经理":@"13995555305"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"罗马";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"小蓝经理":@"15926254164"}, @{@"王经理":@"13476106675"}];
        [snDatas addObject:data];
    }
    
    return snDatas;
}

@end
