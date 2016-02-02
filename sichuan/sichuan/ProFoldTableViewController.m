//
//  ProFoldTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ProFoldTableViewController.h"
#import "FoldTableViewCell.h"
#import "FoldInfo.h"
#import "TitleView.h"
#import "MJRefresh.h"
#import "UIColor+SCColor.h"
#import "ApiManager+Profile.h"

#define kBaseViewTag 100

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ProFoldTableViewController ()<TitleSectionDeleget>

@property (nonatomic, strong) NSArray *info;

@end

@implementation ProFoldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"line to preserve sline to preserve sline to preserve sline to preserve sline to preserve sline to preserve sline to preserve sline to preserve sline to preserve sline to preservesline to preserve sline to preserve sline to preservesline to preserve sline to preserve sline to preserve sline to preserve s", @"message", @"123", @"title", nil];
    
    
    
    
    
//    NSArray *array = [NSArray arrayWithObjects:dic, dic, dic, dic, dic, nil];
//    _info = [FoldInfo fillFoldInformation:array];
    
    //让cell自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self refresh];
    [self initializeDataSource];
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
    FoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileFoldCell"];
    
    if (!cell) {
        
        cell = [[FoldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileFoldCell"];
    }
    
    FoldInfo *info = _info[indexPath.section];
    
    cell.contentLable.attributedText = [NSAttributedString attributedStringWithHTML:info.information];;
    cell.contentLable.font = [UIFont systemFontOfSize:16];
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
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [info.information boundingRectWithSize:CGSizeMake(kWidth - 16, 100000) options:option attributes:attribute context:nil].size;
    
    return size.height;
}

- (void)headViewDidClickButtn:(TitleView *)head {
    
    NSInteger index = head.tag - kBaseViewTag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    
    if (indexPath.section != 0) {
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)initializeDataSource {
    
    [[ApiManager sharedInstance] requestPositionWithPname:@"地理位置和自然状况" completeBlock:^(NSArray *responseObject, NSError *error) {
        
        _info = [FoldInfo fillFoldInformation:responseObject];
        [self.tableView reloadData];
        NSLog(@"position: %@", responseObject);
    }];
}

@end
