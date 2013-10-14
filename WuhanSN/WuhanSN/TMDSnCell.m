//
//  TMDSnCell.m
//  WuhanSN
//
//  Created by Dong Yiming on 10/13/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "TMDSnCell.h"

@implementation TMDSnCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)HEIGHT
{
    return 120.f;
}

@end
