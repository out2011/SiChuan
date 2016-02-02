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

#define kContentEmbedSegue @"ContentEmbedSegue"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface RootViewController ()<UIScrollViewDelegate, MenuSegmentDelegate>

@property (nonatomic, strong) MenuSegment *menuSegment;

@property (nonatomic, strong) NSArray *titles;

@property (weak, nonatomic) IBOutlet UIView *container;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self segmentControlInterfaceSetting];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    //    为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
    //    而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    //    以上面4句是必须的,但是习惯还是加了下面这句话
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:169/255.0 green:10/255.0 blue:0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.000];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_home_logo"] forBarMetrics:UIBarMetricsDefault];
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
    
    _menuSegment = [[MenuSegment alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    _menuSegment.titles = _titles;
    _menuSegment.isLoad = NO;
    _menuSegment.menuDelegate = self;
    [self.view addSubview:_menuSegment];
    
}

- (void)selectedAtIndex:(NSInteger)index {

    [_contentChildVC contentChangedWithIndex:index];
}













@end
