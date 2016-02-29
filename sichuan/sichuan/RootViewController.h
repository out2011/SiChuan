//
//  RootViewController.h
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentViewController;

@interface RootViewController : UIViewController

@property (nonatomic, strong) ContentViewController *contentChildVC;

/// 滑动翻页时，改变button状态
- (void)scrollChangeIndex:(NSInteger)index;
@end
