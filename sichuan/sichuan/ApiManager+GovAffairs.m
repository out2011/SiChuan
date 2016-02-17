//
//  ApiManager+GovAffairs.m
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+GovAffairs.h"

@implementation ApiManager (GovAffairs)

- (NSURLSessionDataTask *)requestNormalWithPages:(NSNumber *)pages
                                            size:(NSNumber *)size
                                             api:(NSString *)api
                                   completeBlock:(SCNormalDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:api parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestOrganizationWithCompleteBlock:(SCOrganizationDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters;
    
    NSURLSessionDataTask *task = [self post:API_Organization
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      completeBlock(responseObject, nil);
                                  }
                              } ];
    
    return task;
    
}


- (NSURLSessionDataTask *)requestOrgListWithPname:(NSString *)pname completeBlock:(SCOrgListDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pname": pname};
    
    NSURLSessionDataTask *task = [self post:API_OrgList
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      completeBlock(responseObject, nil);
                                  }
                              } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestOrgDetailWithNId:(NSNumber *)NId completeBlock:(SCOrgDetailDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"nid": NId};
    
    NSURLSessionDataTask *task = [self post:API_OrgDetail
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      completeBlock(responseObject, nil);
                                  }
                              }];
    
    return task;
}
@end
