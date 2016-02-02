//
//  ContentViewController.h
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface ContentViewController : UIViewController

@property (nonatomic, strong) RootViewController *parentVC;

@property (nonatomic, assign) NSInteger index;


- (void)contentChangedWithIndex:(NSInteger)index;
@end
