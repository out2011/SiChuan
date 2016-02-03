//
//  ProfileTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "MJRefresh.h"
#import "ProfileViewController.h"
#import "ProFoldTableViewController.h"
#import "ProReportTableViewController.h"

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *titles = dic[@"ProfileTitles"];
    
    switch (index) {
        case 1: { ///地理位置和自然状况
            ProFoldTableViewController *positionVC = [segue destinationViewController];
            positionVC.title = titles[index];
        }
            break;
        case 2: { ///最新省情
            ProReportTableViewController *newVC = [segue destinationViewController];
            newVC.title = titles[index];
            newVC.isNews = YES;
        }
            break;
        case 3: { ///统计公报
            ProReportTableViewController *bulletinVC = [segue destinationViewController];
            bulletinVC.title = titles[index];
            bulletinVC.isNews = NO;
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
@end
