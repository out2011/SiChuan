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
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ContentViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *loadVCs;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.loadVCs = [NSMutableArray array];
    
    [self addAllViewController];
    [self scrollViewSetting];
}

- (void)scrollViewSetting {

    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(kScreenW * 8, 0);
    NSLog(@"width: %f\nheight: %f", self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    for (int i = 0; i < 8; i++) {
        
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
    vc.view.frame = CGRectMake(index * kScreenW, 0, self.scrollView.bounds.size.width, kScreenH);
    [self.scrollView addSubview:vc.view];
    [self.loadVCs addObject:vc.view];
}

- (void)contentChangedWithIndex:(NSInteger)index {
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.frame.size.width * index;
    self.scrollView.contentOffset = offset;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger newIndex = scrollView.contentOffset.x / kScreenW;
    
    [_parentVC scrollChangeIndex:newIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
