//
//  AddressTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/2/17.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "AddressTableViewController.h"
#import "AddressTableViewCell.h"
#import "ApiManager+Service.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "MapViewController.h"
#import "SCBackItem.h"

#define kTitle @"地图服务"

@interface AddressTableViewController ()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSUserDefaults *defaults;
@end

@implementation AddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[SCBackItem alloc] init];
    
    [self refresh];
    [self initializeDataSource];
}

- (void)refresh {
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initializeDataSource];
    }];
    tableView.mj_header.backgroundColor = [UIColor colorWithRGB:0xF0F0F0];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AddressTableViewCell *cell = (AddressTableViewCell *)sender;
    
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    NSDictionary *dic = _data[index];
    
    MapViewController *mapVC = [segue destinationViewController];
    mapVC.address = dic[@"address"];
    mapVC.department = dic[@"department"];
    mapVC.title = kTitle;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (!cell) {
        
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressCell"];
    }
    
    NSDictionary *dic = _data[indexPath.row];
    cell.title.text = dic[@"department"];
    cell.address.text = dic[@"address"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 58;
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"address"] != nil) {
        
        _data = [[defaults objectForKey:@"address"] copy];
        [self.tableView reloadData];
    }
    
    [[ApiManager sharedInstance] requestAddressWithCompleteBlock:^(NSArray *responseObject, NSError *error) {
        
        if (!error) {
            
            _data = [responseObject copy];
            [defaults setObject:_data forKey:@"address"];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
}

@end
