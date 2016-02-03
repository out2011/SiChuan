//
//  ArticlesViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ArticlesViewController.h"
#import "SCNoteHelper.h"
#import "ApiManager+Photo.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ArticlesViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeDataSource];
    [self initializeInterface];
}


- (void)initializeDataSource {
    
    if (!self.data) {
        
        [[ApiManager sharedInstance] requestPhotoDetailWithNId:self.nID completeBlock:^(NSDictionary *responseObject, NSError *error) {
            
            _data = [responseObject copy];
            [self initializeInterface];
        }];
    }
}

- (void)initializeInterface {
    
    self.titleLabel.text = _data[@"title"];
    self.noteLabel.text = [SCNoteHelper noteWithDate:_data[@"publishDatetime"] from:_data [@"contentSource"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _contentView.userInteractionEnabled = NO;
    [_contentView loadHTMLString:_data[@"content"] baseURL:[NSURL URLWithString:@""]];
}

#pragma  mark - web view delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *jsCode = [NSString stringWithFormat:@"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var myimg,oldwidth;"
                        "var maxwidth=%f;" //缩放系数
                        "for(i=0;i <document.images.length;i++){"
                        "myimg = document.images[i];"
                        "oldwidth = myimg.width;"
                        "myimg.width = maxwidth;"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);", kScreenW - 32];
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    
    [_contentView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    NSInteger count = [SCNoteHelper imagesNumber:_data[@"content"]];
    
    NSLog(@"count: %ld", count);
    
    _webViewHeight.constant = _contentView.scrollView.contentSize.height - 30 * (count - 1);
    _backgroundView.contentOffset = CGPointMake(0, 0);
}

@end
