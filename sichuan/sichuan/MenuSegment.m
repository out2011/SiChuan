//
//  MenuSegment.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "MenuSegment.h"
#import "UIColor+SCColor.h"
#import "SCDeviceHelper.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kButtonWidth [UIScreen mainScreen].bounds.size.width / 4
#define kBaseTag 1000

@interface MenuSegment()

@end

@implementation MenuSegment

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!_isLoad) {
        
        [self segmentSetting];
        _isLoad = YES;
    }

}

- (void)segmentSetting {
    
    CGFloat height = 54;
    CGFloat font = 19;
    if (![SCDeviceHelper isIphone6]) {
        
        font = 15;
        height = 44;
    }

    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(kButtonWidth * _titles.count, height);
    self.contentOffset = CGPointZero;
    self.backgroundColor = [UIColor colorWithRGB:0xFFE9B8];
    
    if (_titles.count > 0) {
        
        for (int i = 0; i < _titles.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = kBaseTag + i;
            button.frame = CGRectMake(kButtonWidth * i, 0, kButtonWidth, height);
            [button setTitle:_titles[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:font];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor brownColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            if (_selectedIndex == i) {
                button.selected = YES;
            }
            
            [self addSubview:button];
        }
    }
}

- (void)segmentSelected:(UIButton *)sender {
    
    if (_selectedIndex == sender.tag - kBaseTag) {
        
        return;
    }
    
    for (int i = 0; i < _titles.count; i++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:kBaseTag + i];
        button.selected = NO;
    }
    sender.selected = YES;
    
    _selectedIndex = sender.tag - kBaseTag;
    [self.menuDelegate selectedAtIndex:_selectedIndex];
}

- (void)segmentChangeIndex:(NSInteger)index {
    
    for (int i = 0; i < _titles.count; i++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:kBaseTag + i];
        button.selected = NO;
        
        if (index == i) {
            
            button.selected = YES;
        }
    }
    
    _selectedIndex = index;
    
    if (index * kButtonWidth < self.contentOffset.x || (index + 1) * kButtonWidth > self.contentOffset.x + kScreenW) {
        
        if (index > 3) {
            
            [self setContentOffset:CGPointMake(kScreenW, 0) animated:YES];
        }
        else {
            
            [self setContentOffset:CGPointZero animated:YES];
        }
        
    }
}






@end
