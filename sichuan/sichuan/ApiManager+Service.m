//
//  ApiManager+Service.m
//  sichuan
//
//  Created by Lu.L on 16/2/17.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Service.h"

@implementation ApiManager (Service)

- (NSURLSessionDataTask *)requestAddressWithCompleteBlock:(SCAddressDicCompleteBlock)completeBlock {
    
    NSDictionary *parameters;
    
    NSURLSessionDataTask *task = [self post:API_Address
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      completeBlock(responseObject, nil);
                                  }
                              } ];
    
    return task;
}

@end
