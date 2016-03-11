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
    
    NSRange tail = [htmlStr rangeOfString:@"DIV>"];
    
    if (tail.length == 0) {
        
        return htmlStr;
    }
    
    NSRange range = {0, tail.location + tail.length};
    
    NSMutableString *string = [NSMutableString stringWithString:htmlStr];
    [string deleteCharactersInRange:range];
    
    if ([string rangeOfString:@"DIV"].location != NSNotFound) {
        
        [self filterHtmlString:string];
    }
    
    return [NSString stringWithString:string];
}

+ (NSString *)filterImageString:(NSString *)imageStr {
    
    NSRange head = [imageStr rangeOfString:@"<P align=center><A href=\"http://"];
    NSRange tail = [imageStr rangeOfString:@"jpg\"></A></P>"];
    
    if (head.length == 0) {
        
        return imageStr;
    }
    
    NSRange range ={head.location, tail.location - head.location + tail.length + 15 * 3};
    NSMutableString *string = [NSMutableString stringWithString:imageStr];
    [string deleteCharactersInRange:range];
    
    return [NSString stringWithString:string];
}

+ (NSArray *)messageWithString:(NSString *)string {
    
    
    return [string componentsSeparatedByString:@"-"];
}

+ (NSString *)title:(NSString *)title {
    
    if ([title isEqualToString:@"file"]) {
        
        return @"政府文件";
    }
    else if ([title isEqualToString:@"focus"]) {
        
        return @"今日四川";
    }
    
    else {
        
        return @"政务信息";
    }
}

+ (NSArray *)filterEmpty:(NSArray *)array {
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        NSMutableDictionary *dic = [array[i] mutableCopy];
        
        for (NSString *key in [dic allKeys]) {
            
            if ([dic[key] isEqual:[NSNull null]]) {
                
                [dic setObject:@"" forKey:key];
            }
        }
        [result addObject:dic];
    }
    
    return [result copy];
}
@end
