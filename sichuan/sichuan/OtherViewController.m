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
#import "ApiManager.h"
#import "RMUniversalAlert.h"
#import "SCVersionHelper.h"

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
            [self checkVersion];
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

- (void)checkVersion {
    
    __weak OtherViewController *weakSelf = self;
    [[ApiManager sharedInstance] requestVersionWithCompleteBlock:^(NSDictionary *responseObject, NSError *error) {
        
        NSString *nowVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        NSDictionary *versionData = responseObject[@"iOS"];
        NSString *newVersion = versionData[@"version"];
        
        if ([SCVersionHelper updateWithNewVersion:newVersion oldVersion:nowVersion]) {
            
            [weakSelf updateWithUrl:versionData[@"url"]];
        }
        else {
            
            [weakSelf newestVersion];
        }
    }];
}

- (void)newestVersion {
    
    [RMUniversalAlert showAlertInViewController:self withTitle:@"" message:@"当前已是最新版本" cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:^(RMUniversalAlert * _Nonnull alert, NSInteger buttonIndex) {
        
    }];
}

- (void)updateWithUrl:(NSString *)url {
    
    [RMUniversalAlert showAlertInViewController:self withTitle:@"更新" message:@"有新版本，是否更新？" cancelButtonTitle:@"取消" destructiveButtonTitle:@"更新" otherButtonTitles:nil tapBlock:^(RMUniversalAlert * _Nonnull alert, NSInteger buttonIndex) {
        
        switch (buttonIndex) {
            case 1:
                [[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:url]];
                break;
            default:
                break;
        }
    }];
}

@end
