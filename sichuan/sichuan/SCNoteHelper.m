//
//  NoteHelper.m
//  sichuan
//
//  Created by Lu.L on 16/2/1.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "SCNoteHelper.h"

@implementation SCNoteHelper

+ (NSString *)noteWithDate:(NSString *)dateStr from:(NSString *)from {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    
    NSString *result = [formatter stringFromDate:date];
    
    
    
    return [NSString stringWithFormat:@"%@   来源: %@", result, from];
}

+ (NSString *)filterHtmlString:(NSString *)htmlStr {
    
    
    
    
    
    return @"";
}

@end
