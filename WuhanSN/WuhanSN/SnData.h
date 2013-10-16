//
//  SnData.h
//  WuhanSN
//
//  Created by Dong Yiming on 10/12/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum 
{
    SnDistrictWuchang = 0
    , SnDistrictHankou
    , SnDistrictHanyang
}SnDistrict;

@interface SnData : NSObject

@property (assign)  long long               ID;
@property (copy)    NSString                *name;
@property (copy)    NSString                *picture;

@property (assign)  SnDistrict              district;
@property (copy)    NSString                *address;

@property (copy)    NSArray                 *contacts;
@property (copy)    NSString                *cost;
@property (copy)    NSString                *promotion;
@property (copy)    NSString                *time;

@property (assign)  float                   longitude;
@property (assign)  float                   latitude;

@end
