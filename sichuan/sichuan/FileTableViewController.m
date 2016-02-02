//
//  FileTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "FileTableViewController.h"
#import "FileTableViewCell.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "ApiManager+GovFile.h"
#import "SCCompareHelper.h"
#import "FileViewController.h"

@interface FileTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, assign) NSInteger pages;

@end

@implementation FileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pages = 1;
    
    [self refresh];
    [self initializeDataSource];
    [self loadDataIsPulldown:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"fileShowed"]) {
        
        FileTableViewCell *cell = (FileTableViewCell *)sender;
        NSInteger index = [self.tableView indexPathForCell:cell].row;
        
        FileViewController *fileVC = [segue destinationViewController];
        fileVC.data = _data[index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - refresh
- (void)refresh {
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadDataIsPulldown:YES];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadDataIsPulldown:NO];
    }];
    
    tableView.mj_header.backgroundColor = [UIColor colorWithRGB:0xF0F0F0];
    tableView.mj_footer.backgroundColor = [UIColor colorWithRGB:0xF0F0F0];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    if (!cell) {
        
        cell = [[FileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FileCell"];
        
    }
    
    NSDictionary *dic = _data[indexPath.row];
    cell.title.text = dic[@"title"];
    cell.date.text = dic[@"publishDatetime"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

#pragma mark - request
- (void)initializeDataSource {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _data = [NSMutableArray array];
    
    if (![_defaults objectForKey:@"govFile"]) {
        
        self.data = [NSMutableArray array];
    }
    else {
        
        self.data = [[_defaults objectForKey:@"govFile"] mutableCopy];
        [self.tableView reloadData];
    }
}

- (void)loadDataIsPulldown:(BOOL)isPullDown {
    
    NSInteger pages = 1;
    
    if (!isPullDown) {
        
        _pages++;
        pages = _pages;
    }
    
    __weak typeof(self) weakSelf = self;
    [[ApiManager sharedInstance] requestGovFileWithPages:@(pages) size:kPageSize completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        if (!isPullDown) {
            
            NSArray *newData = responseObject[@"list"];
            [_data addObjectsFromArray:newData];
            
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        else {
            
            if (_data.count > 0 && [SCCompareHelper compareNewData:_data withIdentifier:@"govFile"]) {
                
                [weakSelf.tableView.mj_header endRefreshing];
                return;
            }
            _data = [responseObject[@"list"] mutableCopy];
            [weakSelf.tableView.mj_header endRefreshing];
        }
        
        if ([responseObject[@"firstPage"] isEqualToNumber:@(1)]) {
            
            [_defaults setObject:_data forKey:@"govFile"];
        }
        //        NSLog(@"dic12321: %@", _data);
        [weakSelf.tableView reloadData];
    }];
}

@end
