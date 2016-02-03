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
#import "ApiManager.h"

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
    
    GovInfoTableViewController *infoVC = [segue destinationViewController];
    
    switch (index) {
        case 0:{
            
            infoVC.title = titles[index];
            infoVC.api = API_Personnel;
        }
            break;
        case 1:{
            
            infoVC.title = titles[index];
            infoVC.api = API_Bulletin;
        }
            break;
        case 2:{
            
            infoVC.title = titles[index];
            infoVC.api = API_Examination;
        }
            break;
        case 4:{
            
            infoVC.title = titles[index];
            infoVC.api = API_Statistics;
        }
            break;
        case 5:{
            
            infoVC.title = titles[index];
            infoVC.api = API_Plan;
        }
            break;
        default:
            break;
    }
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *titles = dic[@"GovAffairs"];
    
    GovInfoTableViewController *infoVC;
    infoVC.title = titles[indexPath.row];
    
    
    
    
}
@end
