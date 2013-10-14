//
//  TMDSnCell.h
//  WuhanSN
//
//  Created by Dong Yiming on 10/13/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMDSnCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;
@property (weak, nonatomic) IBOutlet UIButton *btnOrder;
@property (weak, nonatomic) IBOutlet UIImageView *ivPic;

@property (weak, nonatomic) IBOutlet UIView *viewBg;

+(float)HEIGHT;

@end
