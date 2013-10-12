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
        
        data = [SnData new];
        data.name = @"时代会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"经理":@"15171420008"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"弘毅";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"文经理":@"13554059185"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"云鼎";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"唐经理":@"13517265386"}, @{@"李经理":@"18908655655"}
                          , @{@"叶经理":@"13545152309"}, @{@"余经理":@"15072496895"}
                          , @{@"牛经理":@"13667264911"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"雄楚国际";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"李经理":@"15927113881"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"海上";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"李经理":@"18707191779"}, @{@"李经理":@"13100624348"}, @{@"李经理":@"15387039956"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"皇城水都";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"彭经理":@"13707128985"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"天成";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"经理":@"13707187587"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"日豪水都";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"鲍经理":@"13554467989"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"卓悦";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"鲍经理":@"15927685665"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"荣安";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"胡经理":@"15927068135"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"芒果水晶";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"姚经理":@"13871122761"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"武昌纽宾凯新时代";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"王总":@"13545008712"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"利济路某会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"头总":@"15207117311"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"马房山7天";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"经理":@"13554430290"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"君宜王朝";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"李经理":@"13971395450"}, @{@"经理":@"18691798593"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"御龙";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"汪经理":@"13720236527"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"电力";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"戴经理":@"13659810378"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"隆程";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"崔经理":@"18627187397"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"尼斯酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"刘经理":@"15207141996"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"水之姚";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"向经理":@"15172361771"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"汉口纽宾凯";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"邓经理":@"15071151680"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"在水一方";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"彭总":@"15623768216"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"水岸国际";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"韩经理":@"13657251566"}];
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"路虎私人会所";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"经理":@"15171496299"}];
        [snDatas addObject:data];
    }
    
    return snDatas;
}

@end
