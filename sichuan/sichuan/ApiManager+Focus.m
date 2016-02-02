//
//  ApiManager+Focus.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Focus.h"

@implementation ApiManager (Focus)

- (NSURLSessionDataTask *)requestFocusListWithPages:(NSNumber *)pages
                                               size:(NSNumber *)size
                                      completeBlock:(SCFocusListDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_FocusList parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
//            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

@end
