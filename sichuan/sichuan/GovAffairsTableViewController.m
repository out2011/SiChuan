//
//  GovAffairsTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "GovAffairsTableViewController.h"
#import "MJRefresh.h"
#import "GovInfoTableViewController.h"
#import "OrganizationTableViewController.h"

@interface GovAffairsTableViewController ()


@end

@implementation GovAffairsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *titles = dic[@"GovAffairs"];
    
    GovInfoTableViewController *infoVC;
    
    if (index != 3) {
        
        infoVC = [segue destinationViewController];
        infoVC.title = titles[index];
    }
}


#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
@end
