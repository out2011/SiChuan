//
//  ApiManager+Photo.m
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Photo.h"

@implementation ApiManager (Photo)

- (NSURLSessionDataTask *)requestPhotoWithPages:(NSNumber *)pages
                                           size:(NSNumber *)size
                                  completeBlock:(SCPhotoDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:api_photo parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestPhotoDetailWithNId:(NSNumber *)nId
                                      completeBlock:(SCPhotoDetailDicCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"nid": nId};
    
    NSURLSessionDataTask *task = [self post:api_photoDetail parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

@end
