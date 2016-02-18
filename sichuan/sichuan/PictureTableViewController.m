//
//  PictureTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "PictureTableViewController.h"
#import "MJRefresh.h"
#import "BlodTableViewCell.h"
#import "ContentTableViewCell.h"
#import "UIColor+SCColor.h"
#import "ApiManager+Photo.h"
#import "SCCompareHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FileTableViewCell.h"
#import "ArticlesViewController.h"

#define kTitle @"图说四川"
#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface PictureTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, assign) NSInteger pages;

@end

@implementation PictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pages = 1;
    
    [self refresh];
    [self initializeDataSource];
    [self loadDataIsPulldown:YES];
    
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
    
    if (indexPath.row == 0) { /// 顶端大图
        
        NSDictionary *dic = _data[indexPath.row];
        
        BlodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
        
        ;
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:dic[@"imagePath"]]];
        cell.title.text = dic[@"title"];
        
        return cell;
    }
    else {
        
        NSDictionary *dic = _data[indexPath.row - 1];
        
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
        if (!cell) {
            
            cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoCell"];
        }
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:dic [@"imagePath"]]];
        cell.title.text = dic[@"title"];
        cell.date.text = dic[@"publishDatetime"];
        return cell;
    }
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return kScreenW / 16 * 9;
    }
    else {
        return 66;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ArticlesViewController *articlesVC = [storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
    articlesVC.title = kTitle;
    
    if (indexPath.row == 0) {
        
        NSDictionary *dic = _data[0];
        articlesVC.nID = dic[@"nID"];
    }
    else {
        
        NSDictionary *dic = _data[indexPath.row - 1];
        articlesVC.nID = dic[@"nID"];
    }
    
    [self.navigationController pushViewController:articlesVC animated:YES];
}

#pragma mark - request
- (void)initializeDataSource {
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _data = [NSMutableArray array];
    
    if (![_defaults objectForKey:@"photo"]) {
        
        self.data = [NSMutableArray array];
    }
    else {
        
        self.data = [[_defaults objectForKey:@"photo"] mutableCopy];
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
    [[ApiManager sharedInstance] requestPhotoWithPages:@(pages) size:kPageSize completeBlock:^(NSDictionary *responseObject, NSError *error) {
        
        if (error) {
            
            return;
        }
        
        if (!isPulldown) {
            
            NSArray *newData = responseObject[@"list"];
            [_data addObjectsFromArray:newData];
            
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        else {
            
            if (_data.count > 0 && [SCCompareHelper compareNewData:_data withIdentifier:@"photo"]) {
                
                [weakSelf.tableView.mj_header endRefreshing];
                return;
            }
            _data = [responseObject[@"list"] mutableCopy];
            [weakSelf.tableView.mj_header endRefreshing];
        }
        
        if ([responseObject[@"firstPage"] isEqualToNumber:@(1)]) {
            
            [_defaults setObject:_data forKey:@"photo"];
        }

        [weakSelf.tableView reloadData];
    }];
}


@end
