//
//  RootViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"
#import "MenuSegment.h"
#import "UIColor+SCColor.h"
#import "SCBackItem.h"
#import "UIImage+SCImage.h"
#import "SCDeviceHelper.h"
#import "ApiManager.h"
#import "SCNoteHelper.h"
#import "ArticlesViewHelper.h"

#define kContentEmbedSegue @"ContentEmbedSegue"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface RootViewController ()<UIScrollViewDelegate, MenuSegmentDelegate>

@property (nonatomic, strong) MenuSegment *menuSegment;
@property (weak, nonatomic) IBOutlet UIView *segmentBackground;

@property (nonatomic, strong) NSArray *titles;

@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentHeight;


@property (nonatomic, strong) UIImageView *customNavigationBar;
@end

@implementation RootViewController


- (UIView *)customNavigationBar {
    if (!_customNavigationBar) {
        
        _customNavigationBar = [[UIImageView alloc] init];
        _customNavigationBar.alpha = 1;
        _customNavigationBar.image = [UIImage imageNamed:@"ic_home_logo"];
        _customNavigationBar.backgroundColor = [UIColor colorWithRGB:0xA91300];
    }
    return _customNavigationBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self notificationCenterSetting];
    [self initializeDataSource];
    [self segmentControlInterfaceSetting];
    
    NSLog(@"width %f", kScreenW);
    
    self.navigationItem.backBarButtonItem = [[SCBackItem alloc] init];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRGB:0xFFFFFF];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.customNavigationBar.frame = CGRectMake(0, 20, kScreenW, 44);
    [self.view addSubview:self.customNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kContentEmbedSegue]) {
        
        _contentChildVC = segue.destinationViewController;
        _contentChildVC.parentVC = self;
    }
}

- (void)initializeDataSource {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Information" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    _titles = dic[@"MenuTitles"];
}

- (void)segmentControlInterfaceSetting {
    
    CGFloat height = 54;
    
    if (![SCDeviceHelper isIphone6]) {
        
        height = 44;
        self.segmentHeight.constant = 44;
    }
    
    _menuSegment = [[MenuSegment alloc] initWithFrame:CGRectMake(0, 0, kScreenW, height)];
    _menuSegment.titles = _titles;
    _menuSegment.isLoad = NO;
    _menuSegment.menuDelegate = self;
    [self.segmentBackground addSubview:_menuSegment];
//    [self.view addSubview:_menuSegment];
}

- (void)scrollChangeIndex:(NSInteger)index {
    
    [_menuSegment segmentChangeIndex:index];
}

- (void)selectedAtIndex:(NSInteger)index {

    [_contentChildVC contentChangedWithIndex:index];
}

#pragma mark - 通知中心
- (void)notificationCenterSetting {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"pushMessage" object:nil];
}

- (void)notificationAction:(NSNotification *)notify {
    
    NSDictionary *dic = notify.userInfo[@"aps"];
    
    if (dic[@"category"]) {
        
        NSArray *message = [SCNoteHelper messageWithString:dic[@"category"]];
        NSNumber *nid = [[[NSNumberFormatter alloc] init] numberFromString:message[0]];
        
        [[ApiManager sharedInstance] requestPushMsgWithNid:nid type:message[1] completeBlock:^(NSDictionary *responseObject, NSError *error) {
            
            ArticlesViewController *articlesVC = [ArticlesViewHelper articlesViewController];
            
            articlesVC.title = [SCNoteHelper title:message[1]];
            articlesVC.data = responseObject;
            
            [self.navigationController pushViewController:articlesVC animated:YES];
        }];
    }
}

- (void)dealloc{
    
    //移除指定的通知，不然会造成内存泄露
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushMessage" object:nil];
}
@end
