//
//  ArticlesView.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ArticlesViewHelper.h"

@implementation ArticlesViewHelper

+ (ArticlesViewController *)articlesViewController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ArticlesViewController *articlesVC = [storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
    
    return articlesVC;
}

@end
