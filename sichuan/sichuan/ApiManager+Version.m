//
//  ApiManager+Version.m
//  sichuan
//
//  Created by Lu.L on 16/3/1.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Version.h"

@implementation ApiManager (Version)

- (NSURLSessionDataTask *)requestVersionWithCompleteBlock:(SCVersionDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"os": @"ios"};
    
    NSURLSessionDataTask *task = [self post:api_version
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      completeBlock(responseObject, nil);
                                  }
                              } ];
    
    return task;
    
}


@end
