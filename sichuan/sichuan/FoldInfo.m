//
//  FoldInfo.m
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "FoldInfo.h"

@implementation FoldInfo


+ (NSArray *)fillFoldInformation:(NSArray *)array {
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i = 0 ; i < array.count; i++) {
        
        FoldInfo *info = [[FoldInfo alloc] init];
        
        NSDictionary *dic = array[i];
        
        info.title = dic[@"title"];
        info.information = dic[@"content"];
        info.isFold = YES;
        
        if (i == 0) {
            info.isFold = NO;
        }
        
        [result addObject:info];
    }
    
    return [result copy];
}
@end
