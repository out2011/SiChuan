//
//  ProReportTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ProReportTableViewController.h"
#import "FileTableViewCell.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "ArticlesViewHelper.h"
#import "SCBackItem.h"
#import "ApiManager+Profile.h"
#import "SCCompareHelper.h"
#import "SCNoteHelper.h"

#define kBaseSize @(15)

@interface ProReportTableViewController ()

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation ProReportTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _pages = 1;
    
    self.navigationItem.backBarButtonItem = [[SCBackItem alloc] init];
    
    [self refresh];
    [self initializeDataSource];
    [self loadDataIsPulldown:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    
    if (!cell) {
        
        cell = [[FileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileCell"];
    }
    // Configure the cell...
    
    NSDictionary *dic = _data[indexPath.row];
    cell.title.text = dic[@"title"];
    cell.date.text = [SCNoteHelper noteWithDate:dic[@"publishDatetime"] from:dic[@"contentSource"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticlesViewController *articlesVC = [ArticlesViewHelper articlesViewController];
    
    articlesVC.title = self.title;
    articlesVC.data = _data[indexPath.row];
    
    [self.navigationController pushViewController:articlesVC animated:YES];
}

#pragma mark - request
- (void)initializeDataSource {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _data = [NSMutableArray array];
    
    NSString *key = @"staNotice";
    if (_isNews) {
        
        key = @"news";
    }
    
    if (![_defaults objectForKey:key]) {
        
        self.data = [NSMutableArray array];
    }
    else {
        
        self.data = [[_defaults objectForKey:key] mutableCopy];
        [self.tableView reloadData];
    }
}

- (void)loadDataIsPulldown:(BOOL)isPulldown {
    
    if (!_isNews) {
        
        [self loadStaNoticeWithIsPulldown:isPulldown];
    }
    else {
        
        [self loadNewsWithIsPulldown:isPulldown];
    }
}

- (void)loadStaNoticeWithIsPulldown:(BOOL)isPulldown {
    
    NSInteger pages = 1;
    
    if (!isPulldown) {
        
        _pages++;
        pages = _pages;
    }
    
    [[ApiManager  sharedInstance] requestSatNoticeWithPages:@(pages) size:kBaseSize completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        [self fillDatawithIdentifier:@"staNotice" isPulldown:isPulldown responseObject:responseObject];
    }];
}

- (void)loadNewsWithIsPulldown:(BOOL)isPulldown {
    
    NSInteger pages = 1;
    
    if (!isPulldown) {
        
        _pages++;
        pages = _pages;
    }
    
    [[ApiManager sharedInstance] requestNewsWithPages:@(pages) size:kBaseSize completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        [self fillDatawithIdentifier:@"news" isPulldown:isPulldown responseObject:responseObject];
    }];
}

- (void)fillDatawithIdentifier:(NSString *)identifier isPulldown:(BOOL)isPulldown responseObject:(NSDictionary *)responseObject {
    
    if (!isPulldown) {
        
        NSArray *newData = [responseObject objectForKey:@"list"];
        [_data addObjectsFromArray:newData];
        
        [self.tableView.mj_footer endRefreshing];
    }
    else {
        
        if (_data.count > 0 && [SCCompareHelper compareNIdWithData:_data withIdentifier:identifier]) {
            
            [self.tableView.mj_header endRefreshing];
            return;
        }
        _data = [[responseObject objectForKey:@"list"] mutableCopy];
        [self.tableView.mj_header endRefreshing];
    }
    
    if ([[responseObject objectForKey:@"firstPage"] isEqualToNumber:@(1)]) {

        [_defaults setObject:_data forKey:identifier];
    }

    [self.tableView reloadData];
}







@end
