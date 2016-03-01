//
//  ApiManager+GovFile.m
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+GovFile.h"

@implementation ApiManager (GovFile)

- (NSURLSessionDataTask *)requestGovFileWithPages:(NSNumber *)pages
                                               size:(NSNumber *)size
                                      completeBlock:(SCGovFileDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:api_govFile parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

@end
