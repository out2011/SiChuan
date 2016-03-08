//
//  ArticlesViewController.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ArticlesViewController.h"
#import "SCNoteHelper.h"
#import "ApiManager.h"
#import "NSString+SCString.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "UIImage+SCImage.h"

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

- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}

- (void)initializeDataSource {
    
    if (!self.data) {
        
        if ([self.api isEqualToString:api_orgDetail]) {
            
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
    
    if (_data[@"webUrl"]) {
        [self inititalizeShareItem];
    }
    
    NSString *htmlStr;
    
    if (_data[@"content"]) {
        
        htmlStr = [SCNoteHelper filterHtmlString:_data[@"content"]];
    }
    else {
        
        htmlStr = [SCNoteHelper filterHtmlString:_data[@"resume"]];
    }
    
    [_contentView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@""]];
}

/// 添加分享按钮
- (void)inititalizeShareItem {
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shared)];
    self.navigationItem.rightBarButtonItem = shareItem;
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
    
    // 重置web view高度
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    _webViewHeight.constant = [height_str integerValue] + 16;

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

- (void)shared {
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
//    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    
    UIImage *image;
    if (self.shareImage) {
        
        image = [self.shareImage sharedImageScaled];
    }
    else {
        
        image = [UIImage imageNamed:@"ic_app"];
    }
    NSString *weiboContent = [NSString  stringWithFormat:@"%@\n%@",_data[@"title"],
                              _data[@"webUrl"]];
    
    [shareParams SSDKSetupShareParamsByText:@"中国四川"
                                     images:image
                                        url:[NSURL URLWithString:_data[@"webUrl"]]
                                      title:_data[@"title"]
                                       type:SSDKContentTypeAuto];
    
    [shareParams SSDKSetupSinaWeiboShareParamsByText:weiboContent
                                               title:_data[@"title"]
                                               image:self.shareImage
                                                 url:[NSURL
                                                      URLWithString:_data[@"webUrl"]]
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:SSDKContentTypeAuto];
    
    
    [ShareSDK showShareActionSheet:self.view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           NSLog(@"11111");
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           NSLog(@"222222");
                           break;
                       }
                       default:
                           break;
                   }
                   
                   
    }];
}


@end
