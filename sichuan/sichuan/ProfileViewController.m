//
//  ProfileViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ProfileViewController.h"
#import "ApiManager+Profile.h"

@interface ProfileViewController ()

@property (nonatomic, strong) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *leader;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *code;

@property (weak, nonatomic) IBOutlet UIButton *website;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
}

- (void)initializeDataSource {
    
    [[ApiManager sharedInstance] requestSituationWithCompleteBlock:^(NSArray *responseObject, NSError *error) {
        
        _data = responseObject[0];
        
        [self initializeInterface];
    }];
}

- (void)initializeInterface {
    
    self.content.text = _data[@"desc"];
    self.leader.text = _data[@"stadholderName"];
    self.city.text = _data[@"provincialCapitalName"];
    self.address.text = _data[@"govAddress"];
    self.code.text = _data[@"postcode"];
    [self.website setTitle:_data[@"webUrl"] forState:UIControlStateNormal];
}

- (IBAction)openWebsite:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sc.gov.cn"]];
}


@end
