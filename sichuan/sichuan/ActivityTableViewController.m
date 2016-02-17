//
//  ActivityTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "ApiManager+Leader.h"
#import "SCCompareHelper.h"
#import "FileTableViewCell.h"
#import "ArticlesViewHelper.h"
#import "SCBackItem.h"

@interface ActivityTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, assign) NSInteger pages;

@end

@implementation ActivityTableViewController

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticlesViewController *articlesVC = [ArticlesViewHelper articlesViewController];
    articlesVC.data = _data[indexPath.row];
    articlesVC.title = self.title;
    [self.navigationController pushViewController:articlesVC animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _data[indexPath.row];
    
        FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell"];
        if (!cell) {
            
            cell = [[FileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailsCell"];
        }
        
        cell.title.text = [dic objectForKey:@"title"];
        cell.date.text = [dic objectForKey:@"publishDatetime"];
        
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

#pragma mark - request
- (void)initializeDataSource {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _data = [NSMutableArray array];
    
    NSString *key = [NSString stringWithFormat:@"activity%@", self.nId];
    if (_isSpeech) {
        
        key = [NSString stringWithFormat:@"speech%@", self.nId];
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
    
    if (!_isSpeech) {
        
        [self loadActivityIsPulldown:isPulldown];
    }
    else {
        
        [self loadSpeechIsPulldown:isPulldown];
    }
}

- (void)loadActivityIsPulldown:(BOOL)isPulldown {
    
    NSInteger pages = 1;
    
    if (!isPulldown) {
        
        _pages++;
        pages = _pages;
    }
    
    __weak typeof(self) weakSelf = self;
    [[ApiManager sharedInstance] requestActivityWithNId:self.nId Pages:@(pages) size:kPageSize completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        [weakSelf fillDatawithIdentifier:@"activity" isPulldown:isPulldown responseObject:responseObject];
    }];
}

- (void)loadSpeechIsPulldown:(BOOL)isPulldown {
    
    NSInteger pages = 1;
    
    if (!isPulldown) {
        
        _pages++;
        pages = _pages;
    }
    __weak typeof(self) weakSelf = self;
    [[ApiManager sharedInstance] requestSpeechWithNId:self.nId Pages:@(pages) size:kPageSize completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        [weakSelf fillDatawithIdentifier:@"speech" isPulldown:isPulldown responseObject:responseObject];
    }];
}

- (void)fillDatawithIdentifier:(NSString *)identifier isPulldown:(BOOL)isPulldown responseObject:(NSDictionary *)responseObject {
    
    NSString *key = [NSString stringWithFormat:@"%@%@", identifier, self.nId];
    
    if (!isPulldown) {
        
        NSArray *newData = [responseObject objectForKey:@"list"];
        [_data addObjectsFromArray:newData];
        
        [self.tableView.mj_footer endRefreshing];
    }
    else {
        
        if (_data.count > 0 && [SCCompareHelper compareNewData:_data withIdentifier:key]) {
            
            [self.tableView.mj_header endRefreshing];
            return;
        }
        _data = [[responseObject objectForKey:@"list"] mutableCopy];
        [self.tableView.mj_header endRefreshing];
    }
    
    if ([[responseObject objectForKey:@"firstPage"] isEqualToNumber:@(1)]) {
        
        [_defaults setObject:_data forKey:key];
    }

    [self.tableView reloadData];
}


@end
