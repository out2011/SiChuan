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
    
    
    
    NSRange head = [htmlStr rangeOfString:@"<DIV"];
    NSRange tail = [htmlStr rangeOfString:@"DIV>"];
    
    if (head.length == 0) {
        
        return htmlStr;
    }
    
    NSRange range = {head.location, tail.location + tail.length + 11};
    
    NSMutableString *string = [NSMutableString stringWithString:htmlStr];
    [string deleteCharactersInRange:range];
    
    return [NSString stringWithString:string];
}

@end
