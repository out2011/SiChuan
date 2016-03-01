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
#import "UIColor+SCColor.h"
#import "ApiManager.h"
#import "SCCompareHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ArticlesViewHelper.h"
#import "SCDeviceHelper.h"

#define kBaseButtonTag 200
#define kTitle @"政府领导"

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
    
    UIButton *button = (UIButton *)sender;
    ActivityTableViewController *activityVC = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"activityShowed"]) {
        NSDictionary *dic = _data[(button.tag - kBaseButtonTag) / 2];
        activityVC.title = @"主要活动";
        activityVC.isSpeech = NO;
        activityVC.nId = dic[@"nID"];
    }
    else {
        NSDictionary *dic = _data[(button.tag - kBaseButtonTag - 1) / 2];
        activityVC.title = @"工作讲话";
        activityVC.isSpeech = YES;
        activityVC.nId = dic[@"nID"];
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
    cell.activity.tag = kBaseButtonTag + indexPath.row * 2;
    cell.speech.tag = kBaseButtonTag + indexPath.row * 2 + 1;
    cell.tag = kBaseButtonTag + indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticlesViewController *leaderVC = [ArticlesViewHelper articlesViewController];
    leaderVC.data = _data[indexPath.row];
    leaderVC.title = kTitle;
    
    [self.navigationController pushViewController:leaderVC animated:YES];
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![SCDeviceHelper isIphone6]) {
        
        return 80;
    }
    return 90;
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
