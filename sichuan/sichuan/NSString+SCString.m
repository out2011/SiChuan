//
//  NSString+SCString.m
//  sichuan
//
//  Created by Lu.L on 16/2/18.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "NSString+SCString.h"

@implementation NSString (SCString)

- (BOOL)isImageSuffix {
    
    if ([self isEqualToString:@"jpg"] || [self isEqualToString:@"png"]) {
        
        return YES;
    }
    
    return NO;
}

@end
