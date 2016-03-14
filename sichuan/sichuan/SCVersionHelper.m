//
//  SCVersionHelper.m
//  sichuan
//
//  Created by Lu.L on 16/3/3.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "SCVersionHelper.h"

@implementation SCVersionHelper

+ (BOOL)updateWithNewVersion:(NSString *)newVersion oldVersion:(NSString *)oldVersion {
    
    NSArray *new = [newVersion componentsSeparatedByString:@"."];
    NSArray *old = [oldVersion componentsSeparatedByString:@"."];
    
    for (int i = 0; i < new.count; i++) {
        
        if ([new[i] floatValue] > [old[i] floatValue]) {
            
            return YES;
        }
    }
    return NO;
}

@end
