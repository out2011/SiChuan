//
//  NoteHelper.h
//  sichuan
//
//  Created by Lu.L on 16/2/1.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCNoteHelper : NSObject

/// 拼接日期、来源
+ (NSString *)noteWithDate:(NSString *)date from:(NSString *)from;

/// 过滤视频
+ (NSString *)filterHtmlString:(NSString *)htmlStr;

/// 过滤图片
+ (NSString *)filterImageString:(NSString *)imageStr;

/// 获取push标题
+ (NSString *)title:(NSString *)title;

/// 拆分push字符串
+ (NSArray *)messageWithString:(NSString *)string;
@end
