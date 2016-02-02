//
//  TitleView.h
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldInfo.h"

@class TitleView;

@protocol TitleSectionDeleget <NSObject>
@optional
-(void)headViewDidClickButtn:(TitleView *)head;
@end

@interface TitleView : UITableViewHeaderFooterView

@property (nonatomic, strong) FoldInfo *info;
@property (nonatomic, weak) id<TitleSectionDeleget> delegate;


+ (TitleView *)headWithTableView:(UITableView *)tableView;
@end
