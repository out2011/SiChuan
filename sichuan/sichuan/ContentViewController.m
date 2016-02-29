//
//  ContentViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ContentViewController.h"
#import "FocusTableViewController.h"
#import "OverViewController.h"
#import "FileTableViewController.h"
#import "GovAffairsViewController.h"
#import "LeaderTableViewController.h"
#import "PictureTableViewController.h"
#import "ServiceViewController.h"
#import "OtherViewController.h"
#import "RootViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ContentViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *loadVCs;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectedIndex = 0;
    self.loadVCs = [NSMutableArray array];
    [self addAllViewController];
    [self scrollViewSetting];
//    [self contentChangedWithIndex:_index];
}

- (void)scrollViewSetting {
    
    self.scrollView.contentSize = CGSizeMake(kScreenW * 8, 0);
    self.scrollView.contentOffset = CGPointZero;
    
    for (int i = 0; i < 2; i++) {
        
        [self addShowViewWithIndex:i];
    }
}

/// 添加子控制器
- (void)addAllViewController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FocusTableViewController *focusVC = [storyboard instantiateViewControllerWithIdentifier:@"FocusTableViewController"];
    [self addChildViewController:focusVC];
    
    OverViewController *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"OverViewController"];
    [self addChildViewController:profileVC];
    
    FileTableViewController *fileVC = [storyboard instantiateViewControllerWithIdentifier:@"FileTableViewController"];
    [self addChildViewController:fileVC];
    
    GovAffairsViewController *govVC = [storyboard instantiateViewControllerWithIdentifier:@"GovAffairsViewController"];
    [self addChildViewController:govVC];
    
    LeaderTableViewController *leaderVC = [storyboard instantiateViewControllerWithIdentifier:@"LeaderTableViewController"];
    [self addChildViewController:leaderVC];
    
    PictureTableViewController *pictureVC = [storyboard instantiateViewControllerWithIdentifier:@"PictureTableViewController"];
    [self addChildViewController:pictureVC];
    
    ServiceViewController *serviceVC = [storyboard instantiateViewControllerWithIdentifier:@"ServiceViewController"];
    [self addChildViewController:serviceVC];
    
    OtherViewController *otherVC = [storyboard instantiateViewControllerWithIdentifier:@"OtherViewController"];
    [self addChildViewController:otherVC];
}

- (void)addShowViewWithIndex:(NSInteger)index {
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * kScreenW, 0, kScreenW, self.view.bounds.size.height);
    [self.scrollView addSubview:vc.view];
    [self.loadVCs addObject:vc.view];
}

/// 点击button后 重置scorll view 显示内容
- (void)resetScrollView {
    
    for (int i = 0; i < self.loadVCs.count; i++) {
        
        UIView *view = self.loadVCs[i];
        [view removeFromSuperview];
    }
    [self.loadVCs removeAllObjects];
    
    if (_selectedIndex == 0) {
        for (int i = 0; i < 2; i++) {
            
            [self addShowViewWithIndex:i];
        }
    }
    else if (_selectedIndex == 7) {
        for (int i = 7; i > 5; i--) {
            
            [self addShowViewWithIndex:i];
        }
    }
    else {
        for (NSInteger i = _selectedIndex - 1; i < _selectedIndex + 2; i++) {
            
            [self addShowViewWithIndex:i];
        }
    }
}

- (void)contentChangedWithIndex:(NSInteger)index {
    
    _selectedIndex = index;
    [self resetScrollView];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.frame.size.width * _selectedIndex;
    self.scrollView.contentOffset = offset;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger newIndex = scrollView.contentOffset.x / kScreenW;
    
    if (newIndex == _selectedIndex) {
        return;
    }
    
    [_parentVC scrollChangeIndex:newIndex];
    
    /// 向左滑动
    if (newIndex < _selectedIndex) {
        
        // 移除最右侧view
        if (newIndex + 2 < 8) {
            UIView *view = self.loadVCs[2];
            [view removeFromSuperview];
            [self.loadVCs removeLastObject];
        }
        
        // 在左侧添加新的view
        if (newIndex > 0) {
            UIViewController *vc = self.childViewControllers[newIndex - 1];
            vc.view.frame = CGRectMake((newIndex - 1) * kScreenW, 0, kScreenW, self.view.bounds.size.height);
            [self.scrollView addSubview:vc.view];
            [self.loadVCs insertObject:vc.view atIndex:0];
        }
    }
    /// 向右滑动
    else if (newIndex > _selectedIndex) {
        
        // 移除最左侧view
        if (newIndex - 2 >= 0) {
            UIView *view = self.loadVCs[0];
            [view removeFromSuperview];
            [self.loadVCs removeObjectAtIndex:0];
        }
        
        // 在右侧添加新的view
        if (newIndex < 7) {
            UIViewController *vc = self.childViewControllers[newIndex + 1];
            vc.view.frame = CGRectMake((newIndex + 1) * kScreenW, 0, kScreenW, self.view.bounds.size.height);
            [self.scrollView addSubview:vc.view];
            [self.loadVCs addObject:vc.view];
        }
    }
    
    _selectedIndex = newIndex;
    
    NSLog(@"newIndex :%ld", self.loadVCs.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
