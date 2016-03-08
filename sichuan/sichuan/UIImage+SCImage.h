//
//  UIImage+SCImage.h
//  sichuan
//
//  Created by Lu.L on 16/2/19.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SCImage)

/// 修改图片尺寸
- (UIImage *)scaled;

/// 分享图片压缩
- (UIImage *)sharedImageScaled;
@end
