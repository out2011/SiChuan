//
//  FoldTableViewCell.h
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLLabel/NSAttributedString+MLLabel.h>
#import "MLLabel.h"

@interface FoldTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MLLabel *contentLable;

@end
