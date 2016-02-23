//
//  LeaderTableViewCell.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "LeaderTableViewCell.h"
#import "SCDeviceHelper.h"

@implementation LeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    if (![SCDeviceHelper isIphone6]) {
        
        self.title.font = [UIFont systemFontOfSize:15];
        self.message.font = [UIFont systemFontOfSize:11];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
