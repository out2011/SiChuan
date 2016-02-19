//
//  OtherTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "OtherTableViewController.h"

@interface OtherTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *versionDetectionCell;

@end

@implementation OtherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [tableView indexPathForCell:self.versionDetectionCell].row) {
        
        NSLog(@"版本检测");
    }
}


@end
