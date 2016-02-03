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
#import "ApiManager+GovAffairs.h"

#define kBaseViewTag 100

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface OrganizationTableViewController ()<TitleSectionDeleget>

@property (nonatomic, strong) NSArray *info;

@end

@implementation OrganizationTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让cell自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self refresh];
    [self initializeDataSource];
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
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    tableView.mj_header.backgroundColor = [UIColor colorWithRGB:0xF0F0F0];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationCell"];
    
    if (!cell) {
        
        cell = [[FoldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrganizationCell"];
    }
    
    FoldInfo *info = _info[indexPath.section];
    
    cell.contentLable.text = info.information;
    
    // Configure the cell...
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TitleView *head = [[TitleView alloc] init];
    head.tag = kBaseViewTag + section;
    head.info = _info[section];
    head.delegate = self;
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoldInfo *info = _info[indexPath.section];
    
    if (info.isFold) {
        return 0;
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [info.information boundingRectWithSize:CGSizeMake(kWidth - 16, 100000) options:option attributes:attribute context:nil].size;
    
    return size.height + 20;
}

- (void)headViewDidClickButtn:(TitleView *)head {
    
    NSInteger index = head.tag - kBaseViewTag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    [self.tableView reloadSections:@[@"index"] withRowAnimation:UITableViewRowAnimationMiddle];
}

#pragma mark - data source
- (void)initializeDataSource {
    
    [[ApiManager sharedInstance] requestOrganizationWithCompleteBlock:^(NSArray *responseObject, NSError *error) {
        
        _info = [FoldInfo fillFoldInformation:responseObject];
        [self.tableView reloadData];
    }];
}













@end
