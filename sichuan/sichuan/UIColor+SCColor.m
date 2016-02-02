//
//  UIColor+LLColor.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "UIColor+SCColor.h"

@implementation UIColor (SCColor)

+ (UIColor *)colorWithRGB:(int)color {
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:1.0f];
}
@end
