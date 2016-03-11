//
//  ServiceViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/22.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ServiceViewController.h"
#import "ApiManager.h"

@interface ServiceViewController ()

@property (nonatomic, strong) UIApplication *application;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _application = [UIApplication sharedApplication];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 办事指南
- (IBAction)openGuide:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_guide]];
}

/// 公交路线
- (IBAction)openTraffic:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_traffic]];
}

/// 社保查询
- (IBAction)openSecurity:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_security]];
}

/// 交通违章
- (IBAction)openRules:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_rules]];
}

/// 路况信息
- (IBAction)openRoad:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_road]];
}

/// 公积金查询
- (IBAction)openFund:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_fund]];
}

/// 办件状态
- (IBAction)openDoc:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_doc]];
}

/// 电子政务大厅
- (IBAction)openHoll:(id)sender {
    
    [_application openURL:[NSURL URLWithString:url_holl]];
}


@end
