//
//  GovAffairsViewController.m
//  sichuan
//
//  Created by Lu.L on 16/2/24.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "GovAffairsViewController.h"
#import "ClassifyCell.h"
#import "GovInfoTableViewController.h"
#import "ApiManager+GovAffairs.h"

@interface GovAffairsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) NSInteger selected;

@end

@implementation GovAffairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.titles = dic[@"GovAffairs"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (_selected != 3) {
        
        NSDictionary *item = self.titles[_selected];
        
        GovInfoTableViewController *infoVC = [segue destinationViewController];
        infoVC.title = item[@"title"];
        
        switch (_selected) {
            case 0:{ // 人事任免
                
                infoVC.api = API_Personnel;
            }
                break;
            case 1:{ // 公示公告
                
                infoVC.api = API_Bulletin;
            }
                break;
            case 2:{ // 招考信息
                
                infoVC.api = API_Examination;
            }
                break;
            case 4:{ // 四川统计
                
                infoVC.api = API_Statistics;
            }
                break;
            case 5:{ // 计划报告
                
                infoVC.api = API_Plan;
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - table view delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"govAffairsCell"];
    if (!cell) {
        cell = [[ClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"govAffairsCell"];
    }
    
    NSDictionary *dic = self.titles[indexPath.row];
    cell.title.text = dic[@"title"];
    cell.image.image = [UIImage imageNamed:dic[@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selected = indexPath.row;
    
    if (indexPath.row == 3) {
        
        [self performSegueWithIdentifier:@"showOrganization" sender:self];
    }
    else {
        
        [self performSegueWithIdentifier:@"showGovInfo" sender:self];
    }
}

@end
