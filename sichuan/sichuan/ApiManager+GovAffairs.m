//
//  ApiManager+GovAffairs.m
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+GovAffairs.h"

@implementation ApiManager (GovAffairs)

- (NSURLSessionDataTask *)requestPersonnelWithPages:(NSNumber *)pages
                                               size:(NSNumber *)size
                                      completeBlock:(SCPersonnelDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Personnel parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestBulletinWithPages:(NSNumber *)pages
                                              size:(NSNumber *)size
                                     completeBlock:(SCBulletinDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Bulletin parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestExaminationWithPages:(NSNumber *)pages
                                                 size:(NSNumber *)size
                                        completeBlock:(SCExaminationDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Examination parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestStatisticsWithPages:(NSNumber *)pages
                                                size:(NSNumber *)size
                                       completeBlock:(SCStatisticsDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Statistics parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestPlanWithPages:(NSNumber *)pages
                                          size:(NSNumber *)size
                                 completeBlock:(SCPlanDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Plan parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

@end
