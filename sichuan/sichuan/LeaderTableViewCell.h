//
//  LeaderTableViewCell.h
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *portraits;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet UIButton *activity;
@property (weak, nonatomic) IBOutlet UIButton *speech;

@end
