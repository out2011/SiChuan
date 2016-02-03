//
//  MenuSegment.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "MenuSegment.h"

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

    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(kButtonWidth * _titles.count, 44);
    self.contentOffset = CGPointZero;
    
    if (_titles.count > 0) {
        
        for (int i = 0; i < _titles.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = kBaseTag + i;
            button.frame = CGRectMake(kButtonWidth * i, 0, kButtonWidth, 40);
            [button setTitle:_titles[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
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
//        button.enabled = YES;
    }
    sender.selected = YES;
//    sender.enabled = NO;
    
    _selectedIndex = sender.tag - kBaseTag;
    [self.menuDelegate selectedAtIndex:_selectedIndex];
}








@end
