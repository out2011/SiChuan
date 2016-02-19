//
//  NSString+SCString.h
//  sichuan
//
//  Created by Lu.L on 16/2/18.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SCString)

/// 判断后缀，是否为图片
- (BOOL)isImageSuffix;

/// 判断后缀，是否为链接
- (BOOL)isHtmlSuffix;
@end
