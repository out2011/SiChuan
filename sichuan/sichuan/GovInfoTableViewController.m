//
//  GovInfoTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "GovInfoTableViewController.h"
#import "FileTableViewCell.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "ApiManager.h"
#import "SCCompareHelper.h"
#import "SCNoteHelper.h"
#import "ArticlesViewController.h"
#import "SCBackItem.h"
#import "SCDeviceHelper.h"

@interface GovInfoTableViewController ()

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation GovInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[SCBackItem alloc] init];
    
    [self refresh];
    [self initializeDataSource];
    [self loadDataIsPulldown:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - refresh
- (void)refresh {
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
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
    
    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GovInfoCell"];
    
    if (!cell) {
        
        cell = [[FileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GovInfoCell"];
    }
    // Configure the cell...
    NSDictionary *dic = _data[indexPath.row];
    cell.title.text = dic[@"title"];
    cell.date.text = [SCNoteHelper noteWithDate:dic[@"publishDatetime"] from:dic[@"contentSource"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![SCDeviceHelper isIphone6]) {
        
        return 65;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ArticlesViewController *articlesVC = [storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
    articlesVC.title = self.title;
    articlesVC.data = _data[indexPath.row];

    [self.navigationController pushViewController:articlesVC animated:YES];
}

#pragma mark - request

- (void)initializeDataSource {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _data = [NSMutableArray array];
    
    if (![_defaults objectForKey:_api]) {
        
        self.data = [NSMutableArray array];
    }
    else {
        
        self.data = [[_defaults objectForKey:_api] mutableCopy];
        [self.tableView reloadData];
    }
}

- (void)loadDataIsPulldown:(BOOL)isPulldown {
    
    NSInteger pages = 1;
    
    if (!isPulldown) {
        
        _pages++;
        pages = _pages;
    }
    
    __weak typeof(self) weakSelf = self;
    [[ApiManager sharedInstance] requestNormalWithPages:@(pages) size:kPageSize api:_api completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        if (error) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        NSArray *newData = responseObject[@"list"];
        
        if (!isPulldown) {
        
            if (newData.count > 0 && [SCCompareHelper compareNIdWithData:newData withIdentifier:_api]) {
                
                [weakSelf.tableView.mj_footer endRefreshing];
                return;
            }
            [_data addObjectsFromArray:newData];
            
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        else {
            
            if (_data.count > 0 && [SCCompareHelper compareNIdWithData:newData withIdentifier:_api]) {
                
                [weakSelf.tableView.mj_header endRefreshing];
                return;
            }
            _data = [responseObject[@"list"] mutableCopy];
            [weakSelf.tableView.mj_header endRefreshing];
        }
        
        if ([responseObject[@"firstPage"] isEqualToNumber:@(1)]) {
            
            [_defaults setObject:newData forKey:_api];
        }
        [weakSelf.tableView reloadData];
    }];
}

@end
