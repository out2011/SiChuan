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
#import "SCNoteHelper.h"

#define kBaseViewTag 100

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ProFoldTableViewController ()<TitleSectionDeleget>

@property (nonatomic, strong) NSArray *info;

@end

@implementation ProFoldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让cell自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self initializeDataSource];
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
    
    NSString *showed = [SCNoteHelper filterImageString:info.information];
    
    cell.contentLable.attributedText = [NSAttributedString attributedStringWithHTML:showed];
    cell.contentLable.font = [UIFont systemFontOfSize:15];
    
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
    
    [self.tableView reloadData];
}

- (void)initializeDataSource {
    
    [[ApiManager sharedInstance] requestPositionWithPname:@"地理位置和自然状况" completeBlock:^(NSArray *responseObject, NSError *error) {
        
        _info = [FoldInfo fillFoldInformation:responseObject];
        [self.tableView reloadData];
    }];
}

@end
