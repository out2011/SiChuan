//
//  AddressTableViewController.m
//  sichuan
//
//  Created by Lu.L on 16/2/17.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "AddressTableViewController.h"
#import "AddressTableViewCell.h"

@interface AddressTableViewController ()

@end

@implementation AddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (!cell) {
        
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressCell"];
    }
    
    return cell;
}



@end
