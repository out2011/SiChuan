//
//  UIImage+SCImage.m
//  sichuan
//
//  Created by Lu.L on 16/2/19.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "UIImage+SCImage.h"

#define kWidth [UIScreen mainScreen].bounds.size.width - 80
#define kHeight 44

@implementation UIImage (SCImage)

- (UIImage *)scaled {
    
    UIGraphicsBeginImageContext(CGSizeMake(kWidth, kHeight));
    [self drawInRect:CGRectMake(10, 0, kWidth, kHeight)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end
