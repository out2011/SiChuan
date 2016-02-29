//
//  OtherViewController.m
//  sichuan
//
//  Created by Lu.L on 16/2/23.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "OtherViewController.h"
#import "ClassifyCell.h"
#import "SCDeviceHelper.h"

@interface OtherViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.titles = dic[@"Others"];
    
    if ([SCDeviceHelper isIphone6]) {
        
        self.viewHeight.constant = 54 * self.titles.count - 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];
    if (!cell) {
        
        cell = [[ClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherCell"];
    }
    
    if (indexPath.row == 1) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    switch (indexPath.row) {
        case 0: {
            NSLog(@"版本检测");
        }
            break;
        case 1: {
            [self performSegueWithIdentifier:@"aboutUs" sender:self];
        }
            break;
        default:
            break;
    }
}

@end
