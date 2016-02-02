//
//  MenuSegment.h
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuSegmentDelegate <NSObject>

- (void)selectedAtIndex:(NSInteger)index;

@end

@interface MenuSegment : UIScrollView

@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) id<MenuSegmentDelegate> menuDelegate;

@end
