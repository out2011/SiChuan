//
//  OverViewController.m
//  sichuan
//
//  Created by Lu.L on 16/2/23.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "OverViewController.h"
#import "ClassifyCell.h"
#import "ProReportTableViewController.h"
#import "SCDeviceHelper.h"

@interface OverViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic) NSInteger selected;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@end

@implementation OverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.titles = dic[@"ProfileTitles"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showMessage"]) {
        
        ProReportTableViewController *newVC = [segue destinationViewController];
        newVC.isNews = _selected == 2;
    }
    
    UIViewController *nextVC = [segue destinationViewController];
    NSDictionary *dic = self.titles[_selected];
    nextVC.title = dic[@"title"];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassifyCell"];
    if (!cell) {
        cell = [[ClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassifyCell"];
    }
    
    NSDictionary *dic = self.titles[indexPath.row];
    
    if (![SCDeviceHelper isIphone6]) {
        cell.title.font = [UIFont systemFontOfSize:17];
    }
    cell.title.text = dic[@"title"];
    cell.image.image = [UIImage imageNamed:dic[@"image"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selected = indexPath.row;
    
    switch (indexPath.row) {
        case 0: {
            [self performSegueWithIdentifier:@"showPorfile" sender:self];
        }
            break;
        case 1: {
            [self performSegueWithIdentifier:@"showGeography" sender:self];
        }
            break;
        case 2: {
            [self performSegueWithIdentifier:@"showMessage" sender:self];
        }
            break;
        case 3: {
            [self performSegueWithIdentifier:@"showMessage" sender:self];
        }
            break;
        default:
            break;
    }
}

@end
