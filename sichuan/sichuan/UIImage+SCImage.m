//
//  UIImage+SCImage.m
//  sichuan
//
//  Created by Lu.L on 16/2/19.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "UIImage+SCImage.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight 44

@implementation UIImage (SCImage)

- (UIImage *)scaled {
    
    UIGraphicsBeginImageContext(CGSizeMake(kWidth, kHeight));
    [self drawInRect:CGRectMake(0, 0, kWidth, kHeight)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (UIImage *)sharedImageScaled {
    
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * 0.6, self.size.height * 0.6));
    [self drawInRect:CGRectMake(0, 0, self.size.width * 0.6, self.size.height * 0.6)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
