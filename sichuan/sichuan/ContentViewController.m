//
//  ContentViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ContentViewController.h"
#import "FocusTableViewController.h"
#import "ProfileTableViewController.h"
#import "FileTableViewController.h"
#import "GovAffairsTableViewController.h"
#import "LeaderTableViewController.h"
#import "PictureTableViewController.h"
#import "ServiceViewController.h"
#import "OtherTableViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _index = 0;
    [self contentChangedWithIndex:_index];
}

- (void)contentChangedWithIndex:(NSInteger)index {
    
    _index = index;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    switch (_index) {
        case 0: {
            
            FocusTableViewController *focusVC = [storyboard instantiateViewControllerWithIdentifier:@"FocusTableViewController"];
            [self viewChanged:focusVC];
        }
            break;
        case 1: {
            
            ProfileTableViewController *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"ProfileTableViewController"];
            [self viewChanged:profileVC];
        }
            break;
        case 2: {
            
            FileTableViewController *fileVC = [storyboard instantiateViewControllerWithIdentifier:@"FileTableViewController"];
            [self viewChanged:fileVC];
        }
            break;
        case 3: {
            
            GovAffairsTableViewController *govVC = [storyboard instantiateViewControllerWithIdentifier:@"GovAffairsTableViewController"];
            [self viewChanged:govVC];
        }
            break;
        case 4: {
            
            LeaderTableViewController *leaderVC = [storyboard instantiateViewControllerWithIdentifier:@"LeaderTableViewController"];
            [self viewChanged:leaderVC];
        }
            break;
        case 5: {
            
            PictureTableViewController *pictureVC = [storyboard instantiateViewControllerWithIdentifier:@"PictureTableViewController"];
            [self viewChanged:pictureVC];
        }
            break;
        case 6: {
            
            ServiceViewController *serviceVC = [storyboard instantiateViewControllerWithIdentifier:@"ServiceViewController"];
            [self viewChanged:serviceVC];
        }
            break;
        case 7: {
            
            OtherTableViewController *otherVC = [storyboard instantiateViewControllerWithIdentifier:@"OtherTableViewController"];
            [self viewChanged:otherVC];
        }
            break;
        default:
            break;
    }
}

- (void)viewChanged:(UIViewController *)viewController {
    
    if (self.childViewControllers.count > 0) {
        
        for (UIViewController *vc in self.childViewControllers) {
            
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
        }
    }
    
    viewController.view.frame = self.view.frame;
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
