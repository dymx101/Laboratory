//
//  TMDDataFactory.m
//  WuhanSN
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "TMDDataFactory.h"
#import "SnData.h"


//拾取坐标: http://api.map.baidu.com/lbsapi/getpoint/

@implementation TMDDataFactory

static NSMutableArray *snDatas = nil;

+(NSMutableArray *)snDatas
{
    if (snDatas == nil)
    {
        snDatas = [NSMutableArray array];
        
        SnData *data = [SnData new];
        data.name = @"水上明珠国际俱乐部";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"曾经理":@"13886195879"}];
        // 30.553392, 114.315523
        data.longitude = 114.315523f;
        data.latitude = 30.553392f;
        data.address = @"中山路312号凤凰大厦B座";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"长江大酒店";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"少鹰":@"15271909791"}];
        // 30.580653, 114.266202
        data.longitude = 114.266202;
        data.latitude = 30.580653;
        data.address = @"汉口解放大道1131号（航空路立交桥旁）";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"汇申会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"王经理":@"15927093911"}, @{@"李经理":@"15971499391"}, @{@"钟经理":@"13871171531"}];
        // 30.602255, 114.310985
        data.longitude = 114.310985;
        data.latitude = 30.602255;
        data.address = @"江岸区沿江大道234号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"循礼门会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"张经理":@"15972039022"}];
        // 30.586091, 114.284307
        data.longitude = 114.284307;
        data.latitude = 30.586091;
        data.address = @"江汉区解放大道1413号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"军悦假日酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"姚经理":@"13720387073"}];
        // 30.529281, 114.370320
        data.longitude = 114.370320;
        data.latitude = 30.529281;
        data.address = @"洪山区八一路415号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"华云大酒店";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"李经理":@"15071395059"}, @{@"李丽":@"1307122988"}];
        // 30.619337, 114.315217
        data.longitude = 114.315217;
        data.latitude = 30.619337;
        data.address = @"江岸区解放大道1480号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"玉泉商务宾馆";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"汪经理":@"13277067121"}];
        // 30.542207, 114.335940
        data.longitude = 114.335940;
        data.latitude = 30.542207;
        data.address = @"武昌区中南路80号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"OK100娱乐城";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"宋经理":@"13517285082"}];
        // 30.534376, 114.317545
        data.longitude = 114.317545;
        data.latitude = 30.534376;
        data.address = @"武昌区中山路519号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"圣宝龙大酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"成经理":@"13638694476"}, @{@"李经理":@"15102720577"}];
        // 30.510563, 114.356019
        data.longitude = 114.356019;
        data.latitude = 30.510563;
        data.address = @"洪山区雄楚大道297号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"华天大酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"柯经理":@"13517226099"}, @{@"张经理":@"13971009271"}, @{@"夏经理":@"13871274116"}];
        data.longitude = 114.346913;
        data.latitude = 30.589236;
        data.address = @"武昌区徐东大街7号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"桂林山水洗浴會所";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"余经理":@"13517255523"}];
        data.longitude = 114.318905;
        data.latitude = 30.545219;
        data.address = @"武昌区中山路309号广西大厦3层";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"御泉会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"王经理":@"13995555305"}];
        data.longitude = 114.268437;
        data.latitude = 30.601553;
        data.address = @"江汉区北湖横路";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"罗马沐足休闲会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"小蓝经理":@"15926254164"}, @{@"王经理":@"13476106675"}];
        data.longitude = 114.289428;
        data.latitude = 30.588469;
        data.address = @"江岸区黄石路";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"时代会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"经理":@"15171420008"}];
        data.longitude = 114.253438;
        data.latitude = 30.578351;
        data.address = @"硚口区解放大道558号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"弘毅大酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"文经理":@"13554059185"}];
        data.longitude = 114.355708;
        data.latitude = 30.551382;
        data.address = @"武昌区东湖路136号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"云鼎商务酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"唐经理":@"13517265386"}, @{@"李经理":@"18908655655"}
                          , @{@"叶经理":@"13545152309"}, @{@"余经理":@"15072496895"}
                          , @{@"牛经理":@"13667264911"}];
        data.longitude = 114.359576;
        data.latitude = 30.573901;
        data.address = @"武昌区中北路岳家嘴154号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"雄楚国际大酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"李经理":@"15927113881"}];
        data.longitude = 114.361271;
        data.latitude = 30.510103;
        data.address = @"洪山区雄楚大道335号";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"海上";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"李经理":@"18707191779"}, @{@"李经理":@"13100624348"}, @{@"李经理":@"15387039956"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"皇城水都";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"彭经理":@"13707128985"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"天成";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"经理":@"13707187587"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"日豪水都";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"鲍经理":@"13554467989"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"卓悦";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"鲍经理":@"15927685665"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"荣安";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"胡经理":@"15927068135"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"芒果水晶";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"姚经理":@"13871122761"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"武昌纽宾凯新时代";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"王总":@"13545008712"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"利济路某会所";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"头总":@"15207117311"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"马房山7天";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"经理":@"13554430290"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"君宜王朝";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"李经理":@"13971395450"}, @{@"经理":@"18691798593"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"御龙";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"汪经理":@"13720236527"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"电力";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"戴经理":@"13659810378"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"隆程";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"崔经理":@"18627187397"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"尼斯酒店";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"刘经理":@"15207141996"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"水之瑶";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"向经理":@"15172361771"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"汉口纽宾凯";
        data.district = SnDistrictHankou;
        data.contacts = @[@{@"邓经理":@"15071151680"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"在水一方";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"彭总":@"15623768216"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"水岸国际";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"韩经理":@"13657251566"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"路虎私人会所";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"经理":@"15171496299"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
        
        data = [SnData new];
        data.name = @"楚民";
        data.district = SnDistrictWuchang;
        data.contacts = @[@{@"小妍":@"13277971591"}];
        data.longitude = 0;
        data.latitude = 0;
        data.address = @"";
        [snDatas addObject:data];
    }
    
    return snDatas;
}

@end
