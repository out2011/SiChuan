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
    
    NSString *suffix = [self substringFromIndex:self.length - 3];
    
    if ([suffix isEqualToString:@"jpg"] || [suffix isEqualToString:@"png"]) {
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isHtmlSuffix {
    
    NSString *suffix = [self substringFromIndex:self.length - 4];
    
    if ([suffix isEqualToString:@"html"]) {
        
        return YES;
    }
    else if ([self rangeOfString:@"aspx"].location != NSNotFound) {
        
        return YES;
    }
    
    return NO;
}
@end
