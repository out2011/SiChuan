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

@property (nonatomic, strong) NSArray *titles;

@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self notificationCenterSetting];
    [self initializeDataSource];
    [self segmentControlInterfaceSetting];
    
    self.navigationItem.backBarButtonItem = [[SCBackItem alloc] init];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
//    [self.navigationController.navigationBar setTranslucent:YES];
//    为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
//    而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
//    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
//    {
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    }
//    以上面4句是必须的,但是习惯还是加了下面这句话
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRGB:0xA91300];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRGB:0xFFFFFF];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    UIImage *image = [UIImage alloc] initWithc
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    UIImage *image = [UIImage imageNamed:@"ic_home_logo"];
    
    UIImage *image = [[UIImage imageNamed:@"ic_home_logo"]
                      resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    UIImageView *titleView = [[UIImageView alloc]initWithImage:image];
//    [self.navigationController.navigationBar addSubview:titleView];
//    [self.navigationController.navigationBar sendSubviewToBack:titleView];
    [self.navigationController.navigationBar setBackgroundImage:[image scaled] forBarMetrics:UIBarMetricsDefault];
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
        self.top.constant = 44;
    }
    
    _menuSegment = [[MenuSegment alloc] initWithFrame:CGRectMake(0, 0, kScreenW, height)];
    _menuSegment.titles = _titles;
    _menuSegment.isLoad = NO;
    _menuSegment.menuDelegate = self;
    [self.view addSubview:_menuSegment];
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
    
    if (notify.userInfo) {
        
        NSArray *message = [SCNoteHelper messageWithString:notify.userInfo[@"payload"]];
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
