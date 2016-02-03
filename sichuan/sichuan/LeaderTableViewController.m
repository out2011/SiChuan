//
//  LeaderTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "LeaderTableViewController.h"
#import "MJRefresh.h"
#import "LeaderTableViewCell.h"
#import "ActivityTableViewController.h"
#import "LeaderInfoViewController.h"
#import "UIColor+SCColor.h"
#import "ApiManager+Leader.h"
#import "SCCompareHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LeaderTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation LeaderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
    [self initializeDataSource];
    [self loadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LeaderTableViewCell *cell = (LeaderTableViewCell *)sender;
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    NSDictionary *dic = _data[index];
    
    if ([segue.identifier isEqualToString:@"leaderInfoShowed"]) {
        
        LeaderInfoViewController *infoVC = [segue destinationViewController];
        infoVC.information = dic[@"resume"];
    }
    else {
        
        ActivityTableViewController *activityVC = [segue destinationViewController];
        activityVC.nId = dic[@"nID"];
        
        if ([segue.identifier isEqualToString:@"activityShowed"]) {
            
            activityVC.title = @"主要活动";
            activityVC.isSpeech = NO;
        }
        else {
            
            activityVC.title = @"工作讲话";
            activityVC.isSpeech = YES;
        }
    }
}

#pragma mark - refresh
- (void)refresh {
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）

        [self loadData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header.backgroundColor = [UIColor colorWithRGB:0xF0F0F0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaderCell"];
    
    if (!cell) {
        cell = [[LeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeaderCell"];
    }
    // Configure the cell...
    
    NSDictionary *dic = _data[indexPath.row];
    
    [cell.portraits sd_setImageWithURL:[NSURL URLWithString:dic[@"avatarPath"]]];
    cell.title.text = [NSString stringWithFormat:@"%@:%@", dic[@"position"], dic [@"leaderName"]];
    cell.message.text = dic[@"resume"];
//    cell.activity.tag = kBaseButtonTag + indexPath.row * 2;
//    cell.speech.tag = kBaseButtonTag + indexPath.row * 2 + 1;
    
    return cell;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark - request
- (void)initializeDataSource {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _data = [NSMutableArray array];
    
    if (![_defaults objectForKey:@"leader"]) {
        
        self.data = [NSMutableArray array];
    }
    else {
        
        self.data = [[_defaults objectForKey:@"leader"] mutableCopy];
        [self.tableView reloadData];
    }
}

- (void)loadData {
    
    
    __weak typeof(self) weakSelf = self;
    [[ApiManager sharedInstance] requestLeaderWithCompleteBlock:^(NSArray *responseObject, NSError *error) {
        
        
        if (_data.count > 0 && [SCCompareHelper compareNewData:_data withIdentifier:@"leader"]) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        _data = [responseObject  mutableCopy];
        
        [_defaults setObject:_data forKey:@"leader"];
        
        [weakSelf.tableView reloadData];
    }];
}


@end
