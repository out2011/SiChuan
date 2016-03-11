//
//  OrganizationTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "OrganizationTableViewController.h"
#import "FoldTableViewCell.h"
#import "FoldInfo.h"
#import "TitleView.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "ApiManager.h"
#import "ArticlesViewHelper.h"
#import "SCBackItem.h"

#define kBaseViewTag 100
#define kTitle @"机构职能"
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface OrganizationTableViewController ()<TitleSectionDeleget>

@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSMutableDictionary *items;

@end

@implementation OrganizationTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[SCBackItem alloc] init];
    
    //让cell自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    _items = [NSMutableDictionary dictionary];
    
    [self initializeDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = [NSString stringWithFormat:@"%ld", (long)section];
    NSArray *items = _items[key];
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationCell"];
    
    if (!cell) {
        
        cell = [[FoldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrganizationCell"];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
    NSArray *array = _items[key];
    NSDictionary *dic = array[indexPath.row];
    cell.label.text = dic[@"title"];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [_items objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
    NSDictionary *data = array[indexPath.row];
    
    ArticlesViewController *articlesVC = [ArticlesViewHelper articlesViewController];
    articlesVC.api = api_orgDetail;
    articlesVC.nID = data[@"nID"];
    articlesVC.title = kTitle;
    
    [self.navigationController pushViewController:articlesVC animated:YES];
}

#pragma mark - table view delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TitleView *head = [TitleView headWithTableView:tableView];
    head.tag = kBaseViewTag + section;
    head.info = _info[section];
    head.delegate = self;
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoldInfo *info = _info[indexPath.section];
    
    if (info.isFold) {
        return 0;
    }
    
    return 45;
}

- (void)headViewDidClickButtn:(TitleView *)head {
    
    NSInteger index = head.tag - kBaseViewTag;
    [self requestItemWithIndex:index];
}

#pragma mark - data source
- (void)initializeDataSource {
    
    [[ApiManager sharedInstance] requestOrganizationWithCompleteBlock:^(NSArray *responseObject, NSError *error) {
        
        _info = [FoldInfo fillFoldInformation:responseObject];
        [self.tableView reloadData];
    }];
}

/// 分段数据请求
- (void)requestItemWithIndex:(NSInteger)index {
    
    FoldInfo *info = _info[index];
    
    if (info.isLoad) {
        
        [self.tableView reloadData];
        return;
    }
    
    [[ApiManager sharedInstance] requestOrgListWithPname:info.title completeBlock:^(NSArray *responseObject, NSError *error) {
        
        info.isLoad = YES;
        [_items setObject:responseObject forKey:[NSString stringWithFormat:@"%ld", (long)index]];

        [self.tableView reloadData];
    }];
}


@end
