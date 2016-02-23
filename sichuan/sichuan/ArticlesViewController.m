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
#import "ApiManager+GovAffairs.h"
#import "NSString+SCString.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ArticlesViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewWidth;

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webViewWidth.constant = kScreenW - 16;
    
    [self initializeDataSource];
    [self initializeInterface];
}


- (void)initializeDataSource {
    
    if (!self.data) {
        
        if ([self.api isEqualToString:API_OrgDetail]) {
            
            [[ApiManager sharedInstance] requestOrgDetailWithNId:self.nID completeBlock:^(NSArray *responseObject, NSError *error) {
                
                _data = [responseObject copy];
                [self initializeInterface];
            }];
            return;
        }
        
        [[ApiManager sharedInstance] requestPhotoDetailWithNId:self.nID completeBlock:^(NSDictionary *responseObject, NSError *error) {
            
            _data = [responseObject copy];
            [self initializeInterface];
        }];
    }
}

- (void)initializeInterface {
    
    self.titleLabel.text = _data[@"title"];
    self.noteLabel.text = [SCNoteHelper noteWithDate:_data[@"publishDatetime"] from:_data[@"contentSource"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _contentView.scrollView.scrollEnabled = NO;
    
    NSString *htmlStr;
    
    if (_data[@"content"]) {
        
        htmlStr = [SCNoteHelper filterHtmlString:_data[@"content"]];
    }
    else {
        
        htmlStr = [SCNoteHelper filterHtmlString:_data[@"resume"]];
    }
    
    [_contentView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@""]];
}

#pragma  mark - web view delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *fixImage = [NSString stringWithFormat:@"var script = document.createElement('script');"
                          "script.type = 'text/javascript';"
                          "script.text = \"function ResizeImages() { "
                          "var myimg;"
                          "var maxwidth=%f;" //缩放系数
                          "for(i=0;i <document.images.length;i++){"
                          "myimg = document.images[i];"
                          "myimg.width = maxwidth;"
                          "}"
                          "}\";"
                          "document.getElementsByTagName('head')[0].appendChild(script);", kScreenW - 32];
    // 拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:fixImage];
    [_contentView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    // 拦截视频，修改视频大小
//    NSString *fixVideo = [NSString stringWithFormat:@"var script = document.createElement('script');"
//                          "script.type = 'text/javascript';"
//                          "script.text = \"function ResizeVideo() { "
//                          "var myIframe = document.getElementsByTagName('iframe')[0];"
//                          "var maxWidth=%f;" //缩放系数
//                          "myIframe.style.width = maxWidth;"
//                          "myIframe.style.height = maxWidth / 4 * 3;"
//                          "}\";"
//                          "document.getElementsByTagName('DIV')[0].appendChild(script);", kScreenW - 32];
//    [webView stringByEvaluatingJavaScriptFromString:fixVideo];
//    [_contentView stringByEvaluatingJavaScriptFromString:@"ResizeVideo();"];
    
    // 重置web view高度
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    _webViewHeight.constant = [height_str integerValue] + 16;
    
//    if ([height_str integerValue] <= kScreenH - 64 && !_data[@"leaderName"]) {
//        
//        _backgroundView.scrollEnabled = NO;
//    }
//    else {
//        
//        _backgroundView.scrollEnabled = YES;
//    }
    
    _backgroundView.contentOffset = CGPointMake(0, 0);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL *url = [request URL];
        NSString *urlStr = [url absoluteString];
        
        if ([urlStr isImageSuffix]) {
            
            return NO;
        }
        else if ([urlStr isHtmlSuffix]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
            return NO;
        }
        return YES;
    }
    return YES;
}


@end
