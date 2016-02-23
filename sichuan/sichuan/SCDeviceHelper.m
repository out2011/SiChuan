//
//  SCDeviceHelper.m
//  sichuan
//
//  Created by Lu.L on 16/2/23.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "SCDeviceHelper.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@implementation SCDeviceHelper

+ (BOOL)isIphone6 {
    
    if (kScreenW < 375) {
        
        return NO;
    }
    return YES;
}


@end
